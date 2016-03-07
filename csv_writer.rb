require 'csv'

class CSVWriter

  HEADERS = ["login", "name", "location", "repo_count"]

  def initialize(headers)
    @headers = headers
  end

  def write_headers
    CSV.open("output.csv", "wb") do |csv|
      csv << HEADERS
    end
  end


end