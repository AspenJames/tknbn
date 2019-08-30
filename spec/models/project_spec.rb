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
			p1 = Project.create(:name => Project.last.name)

      expect(p1).not_to be_valid
    end
	end

	describe 'instance methods' do
		before(:all) do
			@project = Project.create(:name => "Project instance methods")

			5.times do |i|
				@project.items.build({
					:description => "Test todo stage #{i}",
					:stage => 1
				})
			end

			5.times do |i|
				@project.items.build({
					:description => "Test in progress stage #{i}",
					:stage => 2
				})
			end

			5.times do |i|
				@project.items.build({
					:description => "Test done stage #{i}",
					:stage => 3
				})
			end
		end

		describe 'todo' do
			it 'returns an Array of Item objects' do
				todo_items = @project.todo
				expect(todo_items).to be_a_kind_of(Array)
				expect(todo_items.all?{|i| i.kind_of?(Item)}).to be true
			end

			it 'returns only Items with stage 1' do
				todo_items = @project.todo
				expect(todo_items.all?{|i| i.stage === 1}).to be true
			end
		end

		describe 'in_progress' do
			it 'returns an Array of Item objects' do
				todo_items = @project.in_progress
				expect(todo_items).to be_a_kind_of(Array)
				expect(todo_items.all?{|i| i.kind_of?(Item)}).to be true
			end

			it 'returns only Items with stage 2' do
				todo_items = @project.in_progress
				expect(todo_items.all?{|i| i.stage === 2}).to be true
			end
		end

		describe 'done' do
			it 'returns an Array of Item objects' do
				todo_items = @project.done
				expect(todo_items).to be_a_kind_of(Array)
				expect(todo_items.all?{|i| i.kind_of?(Item)}).to be true
			end

			it 'returns only Items with stage 3' do
				todo_items = @project.done
				expect(todo_items.all?{|i| i.stage === 3}).to be true
			end
		end
	end

	describe 'class methods' do
		describe 'self.most_recently_updated' do
			def recently_updated; Project.most_recently_updated end

			it 'returns an Array of Project instances' do
				expect(recently_updated).to be_a_kind_of(Array)
				expect(recently_updated.all?{|i| i.kind_of?(Project)}).to be true
			end

			it 'returns the instance of Project whose items or self has been updated most recently in the first position' do
				p1 = Project.first
				p2 = Project.last

				p1.items.build({
					:description => "update first project",
					:stage => 1
				})
				p1.save

				expect(recently_updated.first.id).to eq(p1.id)

				p2.items.build({
					:description => "update last project",
					:stage => 1
				})
				p2.save

				expect(recently_updated.first.id).to eq(p2.id)
			end
		end
	end
end
