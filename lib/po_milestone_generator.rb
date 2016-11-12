class POMilestoneGenerator
  def initialize(po)
    @po = po
  end

  def generate
    if submitted_for_invoice?
      :submitted_for_invoice
    elsif in_invoicing?
      :in_invoicing
    elsif received?
      :received
    elsif shipped?
      :shipped
    elsif in_production?
      :in_production
    elsif files_needed?
      :files_needed
    elsif po_provided?
      :po_provided
    elsif graphic_amended?
      :graphic_amended
    elsif quote_submitted?
      :quote_submitted
    elsif information_required?
      :information_required
    elsif ready_for_quote?
      :ready_for_quote
    else
      :item_created
    end
  end

  private
  def quote_submitted?
    !@po.quote.to_s.empty? && !graphic_amended? && !information_required?
  end

  def po_provided?
    !@po.purchase_order.to_s.empty? && !files_needed?
  end

  def information_required?
    !ready_for_quote? && (@po.information_required || @po.graphics_information_required?)
  end

  def ready_for_quote?
    @po.ready_for_quote
  end

  def shipped?
    @po.shipped_at && !received?
  end

  def received?
    @po.delivered_at
  end

  def in_production?
    @po.in_production && !shipped? && !files_needed?
  end

  def graphic_amended?
    @po.graphic_amended & !information_required?
  end

  def files_needed?
    @po.files_needed || @po.graphics_files_needed?
  end

  def submitted_for_invoice?
    !@po.invoice.to_s.empty? && !in_invoicing?
  end

  def in_invoicing?
    received? && @po.in_invoicing
  end
end