class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # This function saves the graphic number to the database when a new graphic is created
  # graphic_num includes the region prefix for the user which created the graphic and the ID which is assigned to the graphic upon creation.
  def generate_graphic_number(graphic, user_id)
    graphic_id = graphic.id.to_s.rjust(5, '0') # The '4' is how many zeros will be placed. ex: rjust(4, '0') where graphic_id=20 => '0020'
    po_prefix = graphic.po.po_code if graphic.po.present?
    graphic_number = po_prefix + '-' + graphic_id

    graphic.update(:graphic_number => graphic_number)
  end

  def update_graphic_activity_log(graphic, updater)
    if graphic.activity_ids.empty?
      new_activity = Activity.new(:name => "A graphic was added to PO #{graphic.po.job_code} #{graphic.po.po_code} by #{updater.name}.")
    else
      new_activity = Activity.new(:name => "A graphic in PO #{graphic.po.job_code} #{graphic.po.po_code} was updated by #{updater.name}.")
    end
    new_activity.save
    graphic.activity_ids += [new_activity.id]
  end

  def update_po_activity_log(po, updater)
    if po.activity_ids.empty?
      new_activity = Activity.new(:name => "#{po.job_code} #{po.po_code} was created by #{updater.name}.")
    else
      new_activity = Activity.new(:name => "#{po.job_code} #{po.po_code} was updated by #{updater.name}.")
    end
    new_activity.save
    po.activity_ids += [new_activity.id]
  end

  def set_invoiced
    @invoiced = params[:invoiced] || 0
  end

  def dashboard
  end

  private
  helper_method :milestone_before_quote_submitted?, :milestone_before_in_production?
    def configure_permitted_parameters
      # Add my attributes added to the devise User class
      devise_parameter_sanitizer.for(:sign_up) << :name << :access
      devise_parameter_sanitizer.for(:account_update) << :name << :access
      devise_parameter_sanitizer.for(:account_update) << :region_id << :access
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end

    def status_changed_notifications_recipients(po)
      return nil if Rails.env.development?  # Put your own email if you want to test locally. [User.new(email: "email")]

      if [:ready_for_quote, :graphic_amended, :submitted_for_invoice].include?(po.milestone.name.to_sym)
        Rails.env.staging? ? User.with_role(:io_tester) : User.with_role(:io_user)
      elsif [:quote_submitted, :po_provided, :files_needed, :information_required].include?(po.milestone.name.to_sym)
        Rails.env.staging? ? User.with_role(:io_tester) : User.with_role(:io_user)
      else
        nil
      end
    end

    def send_status_changed_notifications(po)
      if status_changed_notifications_recipients(po)
        PoMailer.status_changed(po, status_changed_notifications_recipients(po)).deliver_now
      end
    end

    def update_po_milestone(po, new_milestone)
      if po.milestone.name.intern != new_milestone
        po.update_attributes(milestone_id: Milestone.find_by_name(new_milestone).id)
        send_status_changed_notifications(po)
      end
    end

    def milestone_before_quote_submitted?(po)
      [:item_created, :ready_for_quote].include?(po.milestone.name.intern)
    end

    def milestone_before_in_production?(po)
      milestone_before_quote_submitted?(po) || [:quote_submitted, :po_provided, :in_production].include?(po.milestone.name.intern)
    end
end
