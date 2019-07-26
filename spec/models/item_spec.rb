# typed: false
require 'pry'
require_relative '../spec_helper.rb'

RSpec.describe Item do
	let(:item_hsh) {{
		:description => "Test item",
		:stage => 1,
		:project_id => 1
	}}

	describe "initialization" do
		it "can be initialized with proper data" do
			i = Item.create(item_hsh)
			expect(i).to be_valid
		end

		it "is not valid with missing data" do
			missing_project_id = item_hsh.merge({:project_id => nil}).compact
			i1 = Item.create(missing_project_id)

			missing_stage = item_hsh.merge({:stage => nil}).compact
			i2 = Item.create(missing_stage)

			missing_desc = item_hsh.merge({:description => nil}).compact
			i3 = Item.create(missing_desc)

			expect(i1).not_to be_valid
			expect(i2).not_to be_valid
			expect(i3).not_to be_valid
		end
	end

	describe "instance methods" do
		let(:itm1){ Item.create(item_hsh) }
		let(:itm2){ Item.create(item_hsh.merge({:stage => 2})) }
		let(:itm3){ Item.create(item_hsh.merge({:stage => 3})) }

		describe "stage_name" do
			it "is a valid method" do
				expect{ itm1.stage_name }.not_to raise_error
				expect{ itm2.stage_name }.not_to raise_error
				expect{ itm3.stage_name }.not_to raise_error
			end

			it "returns a string representation of an item's stage" do
				expect(itm1.stage_name).to eq("TODO")
				expect(itm2.stage_name).to eq("In Progress")
				expect(itm3.stage_name).to eq("Done")
			end
		end
	end
end
