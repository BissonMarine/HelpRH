class LegifrancesController < ApplicationController
  def connection
    # TOKEN for API call -> URL à modifier
    url_api = "https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliCont"
    @response = HTTParty.post(url_api, headers: headers_api, body: body_api.to_json)
  end

  private

  # A utiliser où ? A ADAPTER => JMA
  def headers
    token = Rails.cache.fetch("Authorization", expires_in: 1.hours) do
      ENV.fetch["API_KEY"]
    end

    {
      "Authorization" => token
    }
  end

  def get_token
    url_token = "https://sandbox-oauth.piste.gouv.fr/api/oauth/token"
    @oauth_response = HTTParty.post(url_token, headers: headers_token, body: body_token)
    @token = oauth_response.parsed_response["access_token"]
  end

  def headers_api
    {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      # Token en dur (valable 1h : bearer) =
      'Authorization': "Bearer #{@token}"
    }
  end

  # Clé / valeur recherchée : IDCC 44 par exemple
  def body_api
    # { "ancienId": "MCN97020008A" }
    { "num": "44" }
  end

  def body_token
    {
      "grant_type": "client_credentials",
      "client_id": ENV.fetch["CLIENT_ID"],
      "client_secret": ENV.fetch["SECRET_KEY"],
      "scope": "openid"
    }
  end

  def headers_token
    {
      "Content-Type": "application/x-www-form-urlencoded"
    }
  end
end
