class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, :last_name, :email, presence: true


  after_create :create_profile, :invite_from_admin

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :outgoing_requests, class_name: :Friendship, foreign_key: :requestor_id, 
  						dependent: :destroy
  has_many :incoming_requests, class_name: :Friendship, foreign_key: :requestee_id, 
  						dependent: :destroy
  has_many :likes, dependent: :destroy


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

	def send_friend_request_to(user)
		self.outgoing_requests.create(requestee_id: user.id)
	end

	def is_friends_with?(user)
  		self.friended_by?(user) || self.friended_to?(user)
  	end

  	def friended_by?(user)
  		self.incoming_requests.find_by(requestor_id: user.id, accepted: true)
 	end

  	def friended_to?(user)
  		self.outgoing_requests.find_by(requestee_id: user.id, accepted: true)
 	end

	def has_pending_request_to?(user)
 	 	Friendship.find_by(requestee_id: user.id, requestor_id: self.id, accepted: false)
	end

  	def has_pending_request_from?(user)
  		Friendship.find_by(requestee_id: self.id, requestor_id: user.id, accepted: false)
	end

	def notifications
		self.incoming_requests.where(accepted: false)
	end

	def get_friends
		friendships = "SELECT requestee_id FROM friendships WHERE requestor_id = :user_id 
						AND accepted = true"
		reverse_friendships = "SELECT requestor_id FROM friendships WHERE requestee_id = :user_id 
						AND accepted = true"
		User.where("id IN (#{friendships}) OR id IN (#{reverse_friendships})", user_id: self.id)
	end

	def get_newsfeed
				friendships = "SELECT requestee_id FROM friendships WHERE requestor_id = :user_id 
						AND accepted = true"
		reverse_friendships = "SELECT requestor_id FROM friendships WHERE requestee_id = :user_id 
						AND accepted = true"
		Post.where("user_id IN (#{friendships}) OR user_id IN (#{reverse_friendships}) OR user_id = :user_id", user_id: self.id)
	end 

private

	def invite_from_admin
		Friendship.create(requestor_id: 1, requestee_id: self.id)
	end

end
