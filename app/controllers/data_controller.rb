class DataController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    if session[:current_access_token]
      @me = HTTParty.get "#{ENV['OAUTH_PROVIDER_URL']}/api/v1/users/me.json", { query: { access_token: session[:current_access_token]} }
    else
      redirect_to "#{ENV['OAUTH_PROVIDER_URL']}/oauth/authorize?client_id=#{ENV['OAUTH_TOKEN']}&redirect_uri=#{ENV['OAUTH_REDIRECT_URI']}&response_type=code"
    end
  end

  def create_session
    req_params = "client_id=#{ENV['OAUTH_TOKEN']}&client_secret=#{ENV['OAUTH_SECRET']}&code=#{params[:code]}&grant_type=authorization_code&redirect_uri=#{ENV['OAUTH_REDIRECT_URI']}"
    response = HTTParty.post("#{ENV['OAUTH_PROVIDER_URL']}/oauth/token", body: req_params)
    session[:current_access_token] = response['access_token']
    redirect_to root_path
  end
end
