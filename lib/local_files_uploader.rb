class LocalFilesUploader
  def initialize(pos)
    @pos = pos
  end

  def upload
    @pos.each do |po|
      next unless po.po_code
      dir = po_dir(po)
      next unless directory_exists?(dir)
      upload_quote(po)
      puts "#{po.po_code} quote success!"
      upload_po(po)
      puts "#{po.po_code} po success!"
    end
  end

  private

  def directory_exists?(directory)
    File.directory?(directory)
  end

  def upload_quote(po)
    file_path = upload_file_path(po, quote_file_name_prefix(po))

    if po.quote.to_s.empty? && file_path
      po.quote = Rails.root.join(file_path).open
      po.save!
    end
  end

  def upload_po(po)
    file_path = upload_file_path(po, purchase_order_file_name_prefix(po))
    if po.purchase_order.to_s.empty? && file_path
      po.purchase_order = Rails.root.join(file_path).open
      po.save!
    end
  end

  def upload_file_path(po, prefix)
    postfixes = [" REVISED", " Revised", " revised", "[1]", "_Rev1", "_Updated"]
    postfixes.each do |postfix|
      possible_path = po_dir(po) + '/' + prefix + postfix + '.pdf'
      matched_path = Dir.glob(possible_path).first
      return matched_path if matched_path
    end
    matched_path = Dir.glob(po_dir(po) + '/' + prefix + '.pdf').first
    matched_path ? matched_path : nil
  end

  def purchase_order_file_name_prefix(po)
    po.po_code
  end

  def quote_file_name_prefix(po)
    '*_' + convert_dashes_to_underscores(po.po_code)
  end

  def po_dir(po)
    "upload_files/" + convert_dashes_to_underscores(po.po_code)
  end

  def convert_dashes_to_underscores(string)
    string.chars.map { |char| char == "-" ? "_" : char }.join("")
  end
end





