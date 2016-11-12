class Graphic < ActiveRecord::Base
  belongs_to :user

  has_many :activities_graphics, dependent: :destroy
  has_many :activities, through: :activities_graphics

  belongs_to :side
  belongs_to :substrate

  belongs_to :po
  accepts_nested_attributes_for :po, allow_destroy: false

  validates :hardware_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Price can't have more than 2 decimal places and needs to be greater or equal to 0.00" },
    numericality: { greater_than_or_equal_to: 0}, allow_nil: true
  validates_numericality_of :number_of_versions, :quantity, greater_than: 0, allow_nil: true

  def flagged_information_required?
    information_required
  end

  def self.import(file)
    headers = file.row(1)
    return false if self.correct_headers(headers).empty?
    failed_rows = []
    (2..file.last_row).each do |i|
      row = Hash[[headers, file.row(i)].transpose]
      po_code = row["po_code"].to_s.strip
      correct_attributes = row.select { |k, v| column_names.include?(k) && !self.include_attributes?(k) }
      description = correct_attributes["description"].to_s.strip
      if po_code.to_s.empty?
        failed_rows << i
        next
      end
      graphic = self.graphic(po_code, description)
      unless graphic
        failed_rows << i
        next
      end
      graphic.attributes = correct_attributes
      failed_rows << i unless graphic.save!
    end
    failed_rows
  end

  private
  def self.correct_headers(headers)
    headers.select { |header| column_names.include?(header) }
  end

  def self.graphic(po_code, description)
    if description.to_s.empty?
      po = Po.find_by_po_code(po_code)
      po ? po.graphics.new : nil
    else
      Graphic.find_by_description(description)
    end
  end

  def self.include_attributes?(k)
    [:id, :po_id, :created_at, :updated_at].include?(k.intern)
  end
end