class Post < ActiveRecord::Base
	belongs_to :user

	def age
		time_ago_in_words(self.created_at)
	end
end
