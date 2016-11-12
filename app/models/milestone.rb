class Milestone < ActiveRecord::Base
  NAMES = [
    :item_created,
    :quote_submitted,
    :po_provided,
    :ready_for_quote,
    :quote_submitted,
    :po_provided,
    :files_needed,
    :in_production,
    :shipped,
    :received,
    :submitted_for_invoice,
    :graphic_amended,
    :information_required,
    :in_invoicing
  ]

  has_many :pos

  def name_translated
    I18n.t(name)
  end
end
