# typed: true
class Item < ActiveRecord::Base
	extend T::Sig
	T.unsafe(self).belongs_to :project

	# Validate that the stage is in the range of
	# 1-3, inclusive. This validation is expected
	# to change as new stages/features added
	T.unsafe(self).validates :stage, :inclusion => {:in => (1..3)}

	sig {void}
	def stage_name
		case T.unsafe(self).stage
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
