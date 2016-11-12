require 'roo'

class PoImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_is_admin

  def new

  end

  def create
    if params[:po_imports] && open_spreadsheet(params[:po_imports][:file])
      spreadsheet = open_spreadsheet(params[:po_imports][:file])
      failed_rows = Po.import(spreadsheet, current_user)
      error_messages_for_import(failed_rows)
    else
      flash[:error] = "Unknown file type. Please upload a #{Po::IMPORT_FILE_FORMATS.join('/ ')} file."
    end

    render :new
  end

  private
  def open_spreadsheet(file)
    return nil unless Po::IMPORT_FILE_FORMATS.include?(File.extname(file.original_filename))
    Roo::Spreadsheet.open(file.path)
  end

  def error_messages_for_import(failed_rows)
    if failed_rows == false
      flash[:error] = "Header in import file is incorrect."
    elsif failed_rows.empty?
      flash[:success] = "The file was imported successfully."
    else
      flash[:error] = "Rows #{failed_rows.join(", ")} are incorrect. Please correct the import file."
    end
  end
end
