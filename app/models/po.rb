class Po < ActiveRecord::Base
  IMPORT_FILE_FORMATS = %w(.csv .xls .xlsx)
  has_many :graphics
  accepts_nested_attributes_for :graphics

  has_many :activities_pos
  has_many :activities, through: :activities_pos

  belongs_to :user
  belongs_to :milestone
  # validates :job_code, :po_code, :event_name, presence: true

  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Price can't have more than 2 decimal places and needs to be greater or equal to 0.00" },
    numericality: { greater_than_or_equal_to: 0 },
    allow_nil: true
  validates :shipped_at, presence: { message: "can't be blank if a Tracking Number is provided." }, if: :tracking_number?
  validates :receiver, presence: { message: "can't be blank if Delivered Date & Time is provided." }, if: :delivered_at?
  # validates :information_required, numericality: { equal_to: 1, message: "Information Required cannot be unchecked because graphics are flagged." }, if: :graphics_information_required?
  # validates :notes_information_required, presence: { message: "can't be blank if the Status is Information Required" }, if: :information_required?
  # validates :notes_file_needed, presence: { message: "can't be blank if the Status is Files Needed" }, if: :files_needed?

  mount_uploader :purchase_order, PurchaseOrderUploader
  mount_uploader :invoice, InvoiceUploader
  mount_uploader :quote, QuoteUploader

  scope :with_invoiced_state, lambda  { |invoiced_state|
    return self unless invoiced_state
    invoiced_state.to_i.zero? ? active : invoiced
  }

  scope :active, -> { where(invoice: nil) }

  scope :invoiced, -> { where.not(invoice: nil) }

  def graphics_information_required?
    graphics.map(&:information_required).include?(true)
  end

  def graphics_files_needed?
    graphics.map(&:files_needed).include?(true)
  end

  def information_required?
    information_required || graphics_information_required?
  end

  def files_needed?
    files_needed || graphics_files_needed?
  end

  def waiting_for_quote?
    return false unless milestone
    [:ready_for_quote, :graphic_amended].include?(milestone.name.intern)
  end

  def waiting_for_purchase_order?
    return false unless milestone
    [:quote_submitted, :graphic_amended, :files_needed, :po_provided].include?(milestone.name.intern)
  end

  def waiting_for_invoice?
    return false unless milestone
    [:received, :in_invoicing].include?(milestone.name.intern)
  end

  def can_be_shipped?
    return false unless milestone
    [:in_production].include?(milestone.name.intern)
  end

  def self.import(file, user)
    headers = file.row(1)
    return false if self.correct_headers(headers).empty?
    failed_rows = []
    (2..file.last_row).each do |i|
      row = Hash[[headers, file.row(i)].transpose]
      correct_attributes = row.select { |k, v| column_names.include?(k) && !self.include_attributes?(k) && !v.to_s.empty? }
      correct_attributes = self.format_date_time_attributes(correct_attributes)
      po_code = correct_attributes["po_code"]
      correct_attributes["job_code"] = correct_attributes["job_code"].to_int if correct_attributes["job_code"].is_a?(Float)
      po = !po_code || self.where(po_code: po_code).empty? ? self.new(user_id: user.id) : self.find_by_po_code(po_code)
      po.attributes = correct_attributes
      po[:milestone_id] = Milestone.find_by_name(POMilestoneGenerator.new(po).generate).id
      failed_rows << i unless po.save!
    end
    failed_rows
  end

  def self.upload_local_files
    LocalFilesUploader.new(self.all).upload
  end

  private
  def self.correct_headers(headers)
    headers.select { |header| column_names.include?(header) }
  end

  def self.include_attributes?(k)
    [:id, :created_at, :updated_at].include?(k.intern)
  end

  def self.format_date_time_attributes(hash)
    {}.tap do |new_hash|
      hash.to_a.map { |k, v| new_hash[k] = self.columns_hash[k].type == :datetime ? Time.zone.parse(v) : v }
    end
  end
end
