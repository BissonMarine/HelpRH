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
    # byebug
    response = HTTParty.post(url_api, headers: headers_api, body: body_api.to_json)

    ## ARBORESCENCE QUERY (IDCC 44) =
    # @headers_api = headers_api
    # @title = response["titre"]
    # @response = response
    @highlighted_words = ["ancienneté", "contrat", params[:status], " ans", params[:main_subject]]
    @ccn_name = response["titre"]
    @idcc = response["numeroTexte"]
    @chapters = response["sections"][0]["sections"][0]["sections"]
  end

  private

  def get_token
    url_token = "https://sandbox-oauth.piste.gouv.fr/api/oauth/token"
    oauth_response = HTTParty.post(url_token, headers: headers_token, body: body_token)
    oauth_response.parsed_response["access_token"]
    # raise
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
    { "id": params[:idcc] }
  end

  def body_token
    {
      "grant_type": "client_credentials",
      "client_id": ENV["CLIENT_ID"],
      "client_secret": ENV["CLIENT_SECRET"],
      "scope": "openid"
    }
  end

  def headers_token
    {
      "Content-Type": "application/x-www-form-urlencoded"
    }
  end
end
