# MassUpdater

Bulk updating and inserting of records for ActiveRecord and mysql

## Installation

Add this line to your application's Gemfile:

    gem 'mass_updater'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mass_updater

## Usage

This gem is meant to augment ActiveRecord.  Since it's easy to fall into the trap of looping and recording rows of data using ActiveRecord, that is not always the most efficient way to get the job done.
This gem is here to help reduce round trips to the database and ultimately speed up your app.

Once the gem is included in the project, you can mix it into any existing ActiveRecord models using the "extend" keyword. 
This will make the "insert_or_update" method available in your model.

The insert_or_update method takes 4 parameters:

1. The table name to be updated

2. An array containing the fields to updated

3. An array containing strings of the actual rows to be inserted. This will be used as the VALUES block in the mysql query. The values should be in the same or as the field name passed in parameter 2

4. An array of the fields that should be updated if a mysql unique key is violated. This gem uses mysql's "ON DUPLICATE KEY UPDATE" command to make either an insert or update within one query. Make sure to set up your mysql keys appropriately to ensure rows are updated rather than duplicated under the proper circumstances.

The following example with run one mysql query rather than thousands:

	class Stat < ActiveRecord::Base
		extend MassUpdater

		def record_rows
			stat_inserts = []

			rows = OtherObject.pull_thousands_of_rows_of_data_from_a_some_source()
			rows.each do |row|
				stat_inserts << "'#{self.connection.quote_string(row[:name])}', #{row[:id]}, '#{row[:status]}', #{row[:metric]}, NOW(), NOW()"
			end
			self.insert_or_update('stats', [:name, :api_id, :status, :metric, :created_at, :updated_at], adgroup_inserts, [:name, :status, :metric, :updated_at])
		end
	end

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mass_updater/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
