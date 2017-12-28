module Response
  def json_response(object, status = :ok, auth_token = request.headers['HTTP_AUTH_TOKEN'])
    render json: object.to_json, status: status
            response.headers["auth_token"] = auth_token
  end
end