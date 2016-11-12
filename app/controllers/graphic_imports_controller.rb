class GraphicImportsController < PoImportsController

  def create
    if params[:graphic_imports] && open_spreadsheet(params[:graphic_imports][:file])
      spreadsheet = open_spreadsheet(params[:graphic_imports][:file])
      failed_rows = Graphic.import(spreadsheet)
      error_messages_for_import(failed_rows)
    else
      flash[:error] = "Unknown file type. Please upload a #{Po::IMPORT_FILE_FORMATS.join('/ ')} file."
    end

    render :new
  end
end
