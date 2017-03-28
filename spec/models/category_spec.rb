require "rails_helper"

RSpec.describe Category, :type => :model do

	it 'has many posts' do 
      expect(
      	described_class.reflect_on_association(:posts).macro
      ).to eq :has_many
	end
end