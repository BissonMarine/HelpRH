class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result ]

  def home
    @relation = Conv::CONVENTIONS_ID
  end

  def search
  end

  def result
    @token = get_token
    url_api = "https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliContIdcc"
    response = HTTParty.post(url_api, headers: headers_api, body: body_api.to_json)
    # @headers_api = headers_api
    # @title = response["titre"]
    # byebug
    # @response = response
    @ccn_name = response["titre"]
    @idcc = response["numeroTexte"]
    @sections = response["sections"]
    @vigueur = response["sections"][0]["sections"][0]["etat"]
    @clause = response["sections"][0]["sections"][0]["title"]
    @articles = response["sections"][0]["sections"][0]["sections"][0]["articles"][0]
    @path_title = response["sections"][0]["sections"][0]["sections"][0]["articles"][0]['pathTitle']
    @content = response["sections"][0]["sections"][0]["sections"][0]["articles"][0]['content']
    @article_num = "Article #{response['sections'][0]['sections'][0]['sections'][0]['articles'][0]['num']}"
    @content = response['sections'][0]['sections'][0]['sections'][0]['articles'][0]['content']
  end

  private

  def get_token
    url_token = "https://sandbox-oauth.piste.gouv.fr/api/oauth/token"
    oauth_response = HTTParty.post(url_token, headers: headers_token, body: body_token)
    oauth_response.parsed_response["access_token"]
  end

# attention: pour activer le cache, lancer "rails dev:cache" dans le terminal
  def headers_api
    @session_token ||= Rails.cache.fetch("Authorization", expires_in: 1.hours) do
      get_token
    end
  {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    # Token en dur (valable 1h : bearer) =
    'Authorization': "Bearer #{@session_token}"
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
      "client_id": '57bfb2ae-eab4-4cb0-bdb1-7ca1d734a3e5',
      "client_secret": 'f5baae2e-9989-4ee4-ba75-b183610959f0',
      "scope": "openid"
    }
  end

  def headers_token
    {
      "Content-Type": "application/x-www-form-urlencoded"
    }
  end
end
