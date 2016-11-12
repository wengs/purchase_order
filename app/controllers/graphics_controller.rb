class GraphicsController < ApplicationController
  before_action :set_graphic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /graphics
  # GET /graphics.json
  def index
    @q = graphics.ransack(params[:q])
    @graphics = @q.result.page(params[:page]).per(50)
  end

  def show
  end

  # GET /graphics/new
  def new
    @graphic = Graphic.new(po_id: params[:po_id])
  end

  # GET /graphics/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /graphics
  # POST /graphics.json
  def create
    @graphic = Graphic.new(graphic_params)

    respond_to do |format|
      if can_create_graphic?(@graphic)  && @graphic.save
        if milestone_before_quote_submitted?(@graphic.po)
          @graphic.po.update_attributes(information_required: true, ready_for_quote: false) if information_required?(@graphic)
        elsif !@graphic.po.graphic_amended
          @graphic.po.update_attributes(graphic_amended: true)
        end
        update_po_milestone(@graphic.po, POMilestoneGenerator.new(@graphic.po).generate)
        update_graphic_activity_log(@graphic, current_user)

        format.html {
          flash[:success] = 'Graphic was successfully created.'
          redirect_to edit_po_path(@graphic.po)
        }
        format.json { render :show, status: :created, location: @graphic }
      else
        flash[:error] = "Graphic cannot be created after PO is In Production." if milestone_before_in_production?(@graphic.po)
        format.html { render :new }
        format.json { render json: @graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphics/1
  # PATCH/PUT /graphics/1.json
  def update
    respond_to do |format|
      if (milestone_before_quote_submitted?(@graphic.po) || !current_user.client?) && @graphic.update(graphic_params)
        @graphic.po.update_attributes(information_required: true, ready_for_quote: false) if information_required?(@graphic)
        @graphic.po.update_attributes(files_needed: true) if files_needed?(@graphic)
        update_po_milestone(@graphic.po, POMilestoneGenerator.new(@graphic.po).generate)
        update_graphic_activity_log(@graphic, current_user)
        format.html {
          flash[:success] = 'Graphic was successfully updated.'
          redirect_to edit_po_path(@graphic.po)
        }
        format.json { render :show, status: :ok, location: @graphic }
      else
        flash[:error] = current_user.client? ? "Sorry. You cannot edit this graphic after a quote was submitted." : milestone_error_message(@graphic.po.milestone.name.intern)
        format.html { render :edit }
        format.json { render json: @graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphics/1
  # DELETE /graphics/1.json
  def destroy
    @po = @graphic.po
    if !milestone_before_quote_submitted?(@graphic.po)
      @po.update_attributes(graphic_amended: true)
    end
    update_po_milestone(@graphic.po, POMilestoneGenerator.new(@graphic.po).generate)
    @graphic.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Graphic was successfully destroyed.'
        redirect_to edit_po_path(@po, q: params[:q])
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graphic
      @graphic = Graphic.find(params[:id])
    end

    def graphics
      @graphics = current_user.admin? ? Graphic.all : Graphic.where(user: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graphic_params
      params.require(:graphic).permit(
        :description,
        :quantity,
        :number_of_versions,
        :height,
        :width,
        :hardware_price,
        :substrate_id,
        :side_id,
        :finishing,
        :po_id,
        :information_required,
        :notes_information_required,
        :files_needed,
        :notes_files_needed
      )
    end

    def information_required?(graphic)
      !graphic.po.information_required && graphic.information_required
    end

    def files_needed?(graphic)
      !graphic.po.files_needed && graphic.files_needed
    end

    def milestone_error_message(milestone)
      case milestone
      when :information_required
        "Graphic cannot be created/updated because information needs to be updated on other graphics."
      when :files_needed
        "Graphic cannot be created/updated because files need to be uploaded on other graphics."
      when :graphic_amended
        "Graphic cannot be created/updated because PO is in Graphic Amended status. Please contact Image Options for more details."
      else
        "Sorry. Graphic cannot be created/updated."
      end
    end

    def can_create_graphic?(graphic)
      milestone_before_in_production?(graphic.po) || graphic.po.information_required || graphic.po.files_needed
    end
end
