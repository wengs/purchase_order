class PoMailer < ApplicationMailer
  default from: "iowebapp@io-view.net"

  def status_changed(po, recipients)
    @po = po
    mail to: recipients.flatten.compact.map(&:email).join(", "),
    subject: "The status of PO # #{@po.po_code} is now #{t(@po.milestone.name)}"
  end
end
