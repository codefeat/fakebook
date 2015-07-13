class Friendship < ActiveRecord::Base
	
	belongs_to :requestor, class_name: :User
	belongs_to :requestee, class_name: :User

	validates :requestor_id, :requestee_id, presence: true



end
