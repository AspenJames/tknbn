# typed: false
class Item < ActiveRecord::Base
	belongs_to :project

	# Validate that the stage is in the range of
	# 1-3, inclusive. This validation is expected
	# to change as new stages/features added
	validates :stage, :inclusion => {:in => (1..3)}

	def stage_name
		case stage
		when 1
			"TODO"
		when 2
			"In Progress"
		when 3
			"Done"
		else
			"N/A"
		end
	end
end