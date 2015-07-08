class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, :last_name, :email, presence: true


  after_create :create_profile

  has_one :profile
  has_many :posts

  	def full_name
		self.first_name + " " + self.last_name
	end

	def self.from_omniauth(data)
		where(email: data.info.email).first_or_create do |user|
			user.provider = data.provider
			user.first_name = data.info.first_name
			user.last_name = data.info.last_name
			user.uid = data.uid
			user.password = Devise.friendly_token[0,20]
		end
	end
end
