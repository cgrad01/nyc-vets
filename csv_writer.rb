require 'csv'

class CSVWriter

  def initialize
    CSV.open("output.csv", "wb") do |csv|
      csv << ["login", "name", "location", "repo count"]
    end
  end

end