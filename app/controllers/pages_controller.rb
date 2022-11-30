class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result ]

  def home
    @relation = Conv::CONVENTIONS_ID
  end

  def search
  end

  def result
    # @token = get_token
    url_api = "https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliContIdcc"
    response = HTTParty.post(url_api, headers: headers_api, body: body_api.to_json)
    # byebug
    @title = response["titre"]
  end

  private

  def get_token
    url_token = "https://sandbox-oauth.piste.gouv.fr/api/oauth/token"
    oauth_response = HTTParty.post(url_token, headers: headers_token, body: body_token)
    oauth_response.parsed_response["access_token"]
  end

  def headers_api
    {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      # Token en dur (valable 1h : bearer) =
      'Authorization': "Bearer fBuOrgMKu9xfmbuM78fET3PfUn8ZeR3jUbrMgTnX4KgrYxOXRtmiGu"
    }
  end

  # Clé / valeur recherchée : IDCC 44 par exemple
  def body_api
    # { "ancienId": "MCN97020008A" }
    { "id": "44" }
  end

  def body_token
    {
      "grant_type": "client_credentials",
      "client_id": ENV['CLIENT_ID'],
      "client_secret": ENV['SECRET_KEY'],
      "scope": "openid"
    }
  end

  def headers_token
    {
      "Content-Type": "application/x-www-form-urlencoded"
    }
  end
end
