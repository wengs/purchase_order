class PosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoiced

  def index
    @q = Po.with_invoiced_state(@invoiced).order(created_at: :desc).ransack(params[:q])
    @pos = @q.result.page(params[:page]).per(50)
  end

  def show
    @po = Po.find(params[:id])
    @q = @po.graphics.ransack(params[:q])
    @graphics = @q.result
  end

  def new
    @po = Po.new(user_id: current_user.id, milestone_id: Milestone.find_by_name(:item_created).id)
    graphics = @po.graphics
    @q = graphics.ransack(params[:q])
    @graphics = @q.result.page(params[:page]).per(50)
  end

  def edit
    @po = Po.find(params[:id])
    @q = @po.graphics.ransack(params[:q])
    @graphics = @q.result
  end

  def create
    @po = Po.create(po_params)

    if @po.errors.empty?
      @po.update_attributes(milestone_id: Milestone.find_by_name(::POMilestoneGenerator.new(@po).generate).id)
      send_status_changed_notifications(@po)
      update_po_activity_log(@po, current_user)
      flash[:success] = "PO was successfully created!"
      redirect_to edit_po_path(@po)
    else
      render :new
    end
  end

  def update
    @po = Po.find(params[:id])
    old_milestone = @po.milestone.name if @po.milestone
    not_ready_for_quote(@po)
    ready_for_quote_again(@po)
    quote_uploaded(@po)

    if !cannot_update?(@po) && @po.update_attributes(po_params)
      uncheck_in_invoicing(@po)
      update_po_milestone(@po, ::POMilestoneGenerator.new(@po).generate)
      update_po_activity_log(@po, current_user)
      flash[:success]= "PO was successfully updated!"
    else
      flash[:error] = error_message_for_update(params[:po], @po)
    end

    # get q and graphics for edit.html.erb
    @q = @po.graphics.ransack(params[:q])
    @graphics = @q.result

    render :edit   # Use render instead of redirect so that simple form inline errors can be shown.
  end

  private
  def po_params
    params.require(:po).permit(
      :job_code,
      :po_code,
      :event_name,
      :shipped_at,
      :delivered_at,
      :receiver,
      :shipping_instructions,
      :price,
      :milestone_id,
      :user_id,
      :notes_information_required,
      :notes_file_needed,
      :notes_production,
      :purchase_order,
      :invoice,
      :quote,
      :tracking_number,
      :information_required,
      :files_needed,
      :ready_for_quote,
      :graphic_amended,
      :in_production,
      :due_date,
      :in_invoicing
    )
  end

  def milestone_changed?(po, old_milestone)
    old_milestone != po.milestone.name
  end

  def quote_uploaded?(quote_param, po)
    !quote_param.to_s.empty?
  end

  def information_required?(po)
    !po.information_required && params[:po][:information_required] == "1"
  end

  def uncheck_information_required?(information_required_param, po)
    po.information_required && information_required_param && information_required_param == "0"
  end

  def ready_for_quote_again?(po)
    po.information_required && params[:po][:ready_for_quote] == "1"
  end

  def uncheck_files_needed?(files_needed_param, po)
    po.files_needed && files_needed_param && files_needed_param == "0"
  end

  def checking_in_production_checkbox?(in_production_param, po)
    !po.in_production && in_production_param && in_production_param == "1"
  end

  def not_ready_for_quote(po)
    if information_required?(po)
      params[:po][:ready_for_quote] = false
    end
  end

  def ready_for_quote_again(po)
    if ready_for_quote_again?(po)
      params[:po][:ready_for_quote] = true
      params[:po][:information_required] = false
    end
  end

  def quote_uploaded(po)
    params[:po][:graphic_amended] = false if quote_uploaded?(params[:po][:quote], po)
  end


  def uncheck_in_invoicing(po)
    po.update_attributes(in_invoicing: false) if invoice_uploaded?
  end

  def invoice_uploaded?
    !params[:po][:invoice].to_s.empty?
  end

  def cannot_update?(po)
    (quote_uploaded?(params[:po][:quote], po) && po.graphics_information_required?) ||
    (uncheck_files_needed?(params[:po][:files_needed], po) && po.graphics_files_needed?) ||
    (uncheck_information_required?(params[:po][:information_required], po) && po.graphics_information_required?) ||
    (checking_in_production_checkbox?(params[:po][:in_production], po) && po.graphics_files_needed?)
  end

  def error_message_for_graphics_files_needed(params, po)
    if checking_in_production_checkbox?(params[:in_production], po)
      "Please uncheck Files Needed on the graphics before changing the status of the PO to #{t(:in_production)} or specify graphics that are already in production in the Production Notes."
    elsif uncheck_files_needed?(params[:files_needed], po)
      "Please uncheck Files Needed on the graphics before unchecking Files Needed on this PO."
    end
  end

  def error_message_for_update(params, po)
    if po.graphics_information_required? || po.information_required
      "Some graphics are flagged. Please unflag all graphics before submitting new quote or unchecking Information Required"
    elsif po.graphics_files_needed?
      error_message_for_graphics_files_needed(params, po)
    else
      po.errors.full_messages.to_sentence
    end
  end
end
