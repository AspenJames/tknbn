class Project < ActiveRecord::Base
	has_many :items

	def display
		"#{self.id}. #{self.name}"
	end

	def todo
		self.items.filter do |i|
			i.stage == 1
		end
	end

	def in_progress
		self.items.filter do |i|
			i.stage == 2
		end
	end

	def done
		self.items.filter do |i|
			i.stage == 3
		end
	end

	def self.most_recently_updated
		all.sort do |a, b|
			b.items_most_recently_updated_at <=> a.items_most_recently_updated_at
		end
	end

	def items_most_recently_updated_at
		items.map(&:updated_at).max || self.updated_at
	end
end