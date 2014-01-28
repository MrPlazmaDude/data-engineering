require 'test_helper'
require 'csv'

class DocumentsControllerTest < ActionController::TestCase
  test 'expected file format' do
    parsed_file = CSV.read("#{Rails.root}/example_input.tab", {col_sep: "\t"})
    assert (Document.file_columns - parsed_file[0]).blank?
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    tsv_file = fixture_file_upload('files/example_input.tab')
    assert_not_nil tsv_file

    assert_difference 'Document.count', 4 do
      post 'create', tsv_file: tsv_file
    end
  end
end
