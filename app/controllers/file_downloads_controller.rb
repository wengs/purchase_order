class FileDownloadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_po

  def get_quote
    send_file @po.quote.path, x_sendfile: true, filename: "Quote_#{po_name}_#{current_time}#{File.extname(@po.quote.to_s)}"
  end

  def get_purchase_order
    send_file @po.purchase_order.path, x_sendfile: true, filename: "Purchase_Order_#{po_name}_#{current_time}#{File.extname(@po.purchase_order.to_s)}"
  end

  def get_invoice
    send_file @po.invoice.path, x_sendfile: true, filename: "Invoice_#{po_name}_#{current_time}#{File.extname(@po.invoice.to_s)}"
  end

  private

  def set_po
    @po = Po.find(params[:po_id])
  end

  def po_name
    "#{@po.po_code}-#{@po.job_code}"
  end

  def current_time
    DateTime.now.strftime('%m-%d-%Y_%H%M')
  end
end