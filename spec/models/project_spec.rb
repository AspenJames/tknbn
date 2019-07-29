# typed: false
require_relative '../spec_helper.rb'

RSpec.describe Project do
	describe "initialization" do

    let(:name) { "Test project - #{Time.now()}" }

		it "can be initialized with proper data" do
      p = Project.create(:name => name)

			expect(p).to be_valid
		end

    it "is not valid without a name" do
      p = Project.create

      expect(p).not_to be_valid
    end

    it "prevents duplicating names" do
      p1 = Project.create(:name => name)

      expect(p1).not_to be_valid
    end
	end
end
