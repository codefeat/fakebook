class Profile < ActiveRecord::Base
	
	belongs_to :user

	#Settings for Paperclip (used for avatar)
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
  			default_url: "/images/:style/missing.png"
  	validates_attachment :avatar, content_type: { content_type: /^image\/(jpe?g|png|gif)$/,
                      message: "must be .jpeg, .jpg, .png, or .gif" }

end
