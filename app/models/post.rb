class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_one :category
	validates :title, presence: true
	validates :description, presence: true

  # most simple search, need to refined
  def self.search(params)
    if params
      where('title LIKE ? OR description LIKE ?', "%#{params}%", "%#{params}%")
    else 
      all
    end
  end

  def self.published
    where(published: true)
  end
end


