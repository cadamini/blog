require "rails_helper"

RSpec.describe Comment, :type => :model do
	subject { described_class.new }	
	it 'belongs to post' do 
      expect(
      	described_class.reflect_on_association(:post).macro
      ).to eq :belongs_to
	end
end