# typed: false
require_relative '../spec_helper.rb'

RSpec.describe Project do
	describe "initialization" do
		it "can be initialized with proper data" do
			p = Project.create(:name => "Test project")

			expect(p).to be_valid
		end
	end
end
