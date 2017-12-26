module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    puts "logging in"
    #session[:user_id] = user.id
    #puts session[:user_id]
    user.auth_token= SecureRandom.uuid
    user.save!
    puts  user.auth_token
    puts "Done!"
  end

  # Returns the current logged-in user (if any).
  def current_user
    auth_token = request.headers['HTTP_AUTH_TOKEN']
    puts auth_token
    @current_user ||= User.find_by(auth_token: auth_token)
    #puts @current_user.name + " is logged in"
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  # Logs out the current user.
  def log_out
    current_user
    @current_user.auth_token = nil
    @current_user.save!
    @current_user = nil
  end
  
  def isUser
    puts @current_user.type
    @current_user.type == "Client"
  end
  
  def isGoalie
    puts @current_user.type
    @current_user.type == "Goalie"
  end
end