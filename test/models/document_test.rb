require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  test 'file columns length' do
     assert Document.file_columns.length == 6
  end
end
