class SessionsController < ApplicationController
  
  include SessionsHelper
  
  def create
    puts params[:session][:email].downcase
    user = User.find_by(email: params[:session][:email].downcase)
    if user #&& user.authenticate(params[:session][:password])
      log_in user
      puts user.auth_token
      json_response(true.to_json, :created, user.auth_token)
    else
      json_response(false.to_json, :bad_request)
    end
  end

  def destroy
    log_out
    json_response(nil, :accepted)
  end
  
end