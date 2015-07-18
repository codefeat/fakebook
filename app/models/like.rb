class Like < ActiveRecord::Base
	belongs_to :likable, polymorphic: true
	belongs_to :user

	validates :likable_id, :likable_type, :user_id, presence: true
	validates :user_id, uniqueness: {scope: [:likable_id, :likable_type]}
end
