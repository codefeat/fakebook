class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, :last_name, :email, presence: true


  after_create :create_profile

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :outgoing_requests
  has_many :incomming_requests


	
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

	def self.send_friend_request_to(user)
		self.friendships.create(requestee_id: user.id)
	end
end
