class User < ActiveRecord::Base
  attr_accessible :address, :contactno, :designation, :email, :membershipno, :name
      def self.import_member
        temp = Rails.root.join('public', 'members.xlsx').to_s
  
      spreadsheet = open_spreadsheet(temp)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      puts "row added"
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end
  
    def self.open_spreadsheet(temp)
  
     
  #  case File.extname(file.original_filename)
  #  when '.csv' then Csv.new(file.path, nil, :ignore)
  #  when '.xls' then Excel.new(file.path, nil, :ignore)
      Roo::Excelx.new(temp, nil, :ignore)
  
  #  else raise "Unknown file type: #{file.original_filename}"
  #  end
end
end
