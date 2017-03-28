class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #,:confirmable
  #before_create :confirmation_token
  validates :email, uniqueness: true

  # refactor: check for admin column true
  def admin?
    email == 'adamini@gmx.de'
  end
end

private

def confirmation_token
	if self.confirm_token.blank?
	  self.confirm_token = SecureRandom.urlsafe_base64.to_s
	end
end