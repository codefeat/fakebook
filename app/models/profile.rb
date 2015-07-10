class Profile < ActiveRecord::Base
	
	belongs_to :user

	#Settings for Paperclip (used for avatar)
	has_attached_file :avatar, styles: { small: "120x120>", medium: "160x160>", thumb: "40x40>" }, 
  			default_url: "/images/missing_avatar/:style.jpeg"
  	validates_attachment :avatar, content_type: { content_type: /^image\/(jpe?g|png|gif)$/,
                      message: "must be .jpeg, .jpg, .png, or .gif" }

end
