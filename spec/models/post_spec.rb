require "rails_helper"

RSpec.describe Post, :type => :model do
	subject { described_class.new }

	before do
	  create :post, title: 'John', description: 'Doe'
	  create :post, title: 'Mr', description: 'X'
	end

	it 'has many comments' do 
      expect(
      	described_class.reflect_on_association(:comments).macro
      ).to eq :has_many
	end

	it 'has one category' do 
      expect(
      	described_class.reflect_on_association(:category).macro
      ).to eq :has_one
	end

	it 'validates the presence of attribute title' do
		subject.title = nil
		subject.description = 'description'
		expect(subject).to_not be_valid
	end

	it 'validates the presence of attribute description' do
		subject.title = 'title'
		subject.description = nil
		expect(subject).to_not be_valid
	end

	it "can search for the title" do
		post = Post.search('John')
		expect(post.count).to eq 1
	end

	it "can search for the title" do
		post = Post.search('test')
		expect(post.count).to eq 0
	end

	it 'returns all items if no params specified' do 
	  post = Post.search(nil)
	  expect(post.count).to eq 2
	end
end