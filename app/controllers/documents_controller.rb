class DocumentsController < ApplicationController

  require 'csv'

  def index
  end

  def new
  end

  def create
    if params[:tsv_file].present?
      parse_file(params[:tsv_file])
    else
      redirect_to :root
    end
  end

  private

  def parse_file(file)

    tsv_file_contents = file.read
    parsed_file = CSV.parse(tsv_file_contents, {col_sep: "\t"})

    #verify that the file being uploaded has matching column names before trying to parse it.
    if (Document.file_columns - parsed_file[0]).blank?
      file_gross = save_data(parsed_file)

      @gross = {
          total: (Document.sum :item_price),
          last: file_gross
      }
      render :new

    else
      redirect_to :root
    end

  end

  def save_data(parsed_file)

    file_gross = 0.0
    parsed_file[1..4].each do |line_item|

      document = Document.create(
          purchaser_name: line_item[0],
          item_description: line_item[1],
          item_price: line_item[2],
          purchase_count: line_item[3],
          merchant_address: line_item[4],
          merchant_name: line_item[5]
      )

      file_gross += document.item_price
    end

    file_gross

  end

end
