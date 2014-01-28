class Document < ActiveRecord::Base

  def self.file_columns
    return self.column_names.delete_if{|c| %w(id created_at updated_at).include? c}.map{|x| x.humanize.downcase}
  end

end
