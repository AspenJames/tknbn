# typed: strict
class Project < ActiveRecord::Base
	extend T::Sig
	T.unsafe(self).has_many :items

	T.unsafe(self).validates :name, :presence => true
	T.unsafe(self).validates :name, :uniqueness => true

	sig {returns(T::Array[Item])}
	def todo
		items.filter do |i|
			i.stage == 1
		end
	end

	sig {returns(T::Array[Item])}
	def in_progress
		items.filter do |i|
			i.stage == 2
		end
	end

	sig {returns(T::Array[Item])}
	def done
		items.filter do |i|
			i.stage == 3
		end
	end

	sig {returns(T::Array[Project])}
	def self.most_recently_updated
		T.unsafe(self).all.sort do |a, b|
			b.items_most_recently_updated_at <=> a.items_most_recently_updated_at
		end
	end

	sig {returns(T::Array[Item])}
	def items_most_recently_updated_at
		items.map(&:updated_at).max || T.unsafe(self).updated_at
	end
end
