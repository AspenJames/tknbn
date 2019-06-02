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
end