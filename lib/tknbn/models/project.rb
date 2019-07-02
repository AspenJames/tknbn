# typed: true
class Project < ActiveRecord::Base
	extend T::Sig
	T.unsafe(self).has_many :items

	T.unsafe(self).validates :name, :uniqueness => true

	sig {returns(T::Array[Item])}
	def todo
		T.unsafe(self).items.filter do |i|
			i.stage == 1
		end
	end

	sig {returns(T::Array[Item])}
	def in_progress
		T.unsafe(self).items.filter do |i|
			i.stage == 2
		end
	end

	sig {returns(T::Array[Item])}
	def done
		T.unsafe(self).items.filter do |i|
			i.stage == 3
		end
	end
end
