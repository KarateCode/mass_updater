require "mass_updater/version"

module MassUpdater
	def insert_or_update(table_name, record_fields, inserts, update_fields)
		if inserts.count > 0
			update_sql = []
			update_fields.each do |f|
				update_sql << "#{f} = VALUES(#{f})"
			end

			sql = "INSERT INTO #{table_name} (`#{record_fields.join('`, `')}`)
VALUES (#{inserts.join("),\n(")})
ON DUPLICATE KEY UPDATE 
#{update_sql.join(", ")};"
			ActiveRecord::Base.connection.execute(sql)
		end
	end

	def insert_ignore(table_name, record_fields, inserts)
		if inserts.count > 0
			update_sql = ""

			sql = "INSERT IGNORE INTO #{table_name} (`#{record_fields.join('`, `')}`)
VALUES (#{inserts.join("),\n(")});"
			ActiveRecord::Base.connection.execute(sql)
		end
	end

	def build_api_hash(relation, field, ids)
		hash = {}
		plucks = relation.where(["#{field} IN (?)", ids]).map{|c| [c.id, c.api_id]}
		plucks.each do |c|
			hash[c.last] = c.first
		end
		hash
	end
end
