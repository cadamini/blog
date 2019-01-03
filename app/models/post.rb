class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_one :category
	validates :title, presence: true
	validates :description, presence: true

  attr_accessor :image, :remote_image_url
  mount_uploader :image, ImageUploader

  # most simple search, need to refined
  def self.search(params)
    if params
      where('title ILIKE ? OR description ILIKE ?', "%#{params}%", "%#{params}%")
    else 
      all
    end
  end

  def self.published
    where(published: true)
  end

  def self.published_count_per_category
    published.group(:category_id).count
  end
end


