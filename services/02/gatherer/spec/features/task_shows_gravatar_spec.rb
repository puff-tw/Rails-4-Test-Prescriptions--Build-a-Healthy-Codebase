#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

include Warden::Test::Helpers

describe "adding a new task" do

  fixtures :all

  before(:each) do
    users(:user).update_attributes(email: "noelrappin@gmail.com")
    tasks(:one).update_attributes(user_id: users(:user).id)
    login_as users(:user)
  end

  it "shows a gravatar", :vcr do
    visit project_path(projects(:bluebook))
    url = "http://www.gravatar.com/avatar/6b767d8a4c9910e007c122d81eb4de73"
    within("#task_1") do
      expect(page).to have_selector(".completed_by", text: users(:user).email)
      expect(page).to have_selector("img[src='#{url}']")
    end
  end

end
