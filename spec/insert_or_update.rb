require File.join(File.dirname(__FILE__), *%w[spec_helper])

class LineItem < ActiveRecord::Base
	has_many :stats
end

class Stat < ActiveRecord::Base
	belongs_to :line_item
	extend MassUpdater

	def record_rows
		stat_inserts = []
		line_item_ids = rpt.map{|r| r[:line_item_api_id]}.uniq.compact
		line_item_hash = self.build_api_hash(LineItem, 'api_id', line_item_ids)

		rows = OtherObject.pull_thousands_of_rows_of_data_from_a_some_source()
		rows.each do |row|
			stat_inserts << "'#{self.connection.quote_string(row[:name])}', #{row[:id]}, #{line_item_hash[row[:id]]}, '#{row[:status]}', #{row[:metric]}, NOW(), NOW()"
		end
		self.insert_or_update('stats', [:name, :api_id, :line_item_id, :status, :metric, :created_at, :updated_at], adgroup_inserts, [:name, :status, :metric, :updated_at])
	end
end

describe ".insert_or_update" do
	it "should do something..." do
		
	end
end
