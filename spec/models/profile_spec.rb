require 'rails_helper'

RSpec.describe Profile, type: :model do

	it "is created when a User is created" do
		user = User.create(first_name: "John", last_name: "Smith", 
			email: "js@sample.com", password: "testpass", password_confirmation: "testpass")
		expect(user.profile) != nil
	end
  
end
