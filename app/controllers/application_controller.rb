class ApplicationController < ActionController::API
  include Response
  include SessionsHelper
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        puts "not logged in"
      end
    end
  
end
