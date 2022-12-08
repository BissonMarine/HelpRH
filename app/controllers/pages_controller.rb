class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result, :filter ]

  def home
    @relation = Conv::CONVENTIONS_ID
  end

  def search
  end

  def filter
  end

  def result
    @token = get_token
    url_api = "https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliContIdcc"
    # byebug
    response = HTTParty.post(url_api, headers: headers_api, body: body_api.to_json)

    # raise
    ## ARBORESCENCE QUERY (IDCC 44) =
    # @headers_api = headers_api
    # @title = response["titre"]
    # @response = response
    @highlighted_words = [params[:status], params[:main_subject]]
    @highlighted_words << params[:secondary_subject] if params[:secondary_subject]
    @ccn_name = response["titre"]
    @idcc = response["numeroTexte"]

    @chapters = []
    # byebug
    if response.key?("sections")
      response["sections"].each do |section|
        # first level iteration over the many possible section

        if section.key?("articles") && !section["articles"].blank?
          @chapters << section
        end

        if section.key?("sections")
          section["sections"].each do |sub_section|
            if sub_section.key?("articles") && !sub_section["articles"].blank?
              @chapters << sub_section
            end

            if sub_section.key?("sections")
              sub_section["sections"].each do |sub_sub_section|
                if sub_sub_section.key?("articles") && !sub_sub_section["articles"].blank?
                  @chapters << sub_sub_section
                end

                if sub_sub_section.key?("sections")
                  sub_sub_section["sections"].each do |sub_sub_sub_section|
                    if sub_sub_sub_section.key?("articles") && !sub_sub_sub_section["articles"].blank?
                      @chapters << sub_sub_sub_section
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    # if response["sections"][0].key?("articles") && !response["sections"][0]["articles"].blank?
    #   @chapters = response["sections"]
    # end
    # if response["sections"][0]["sections"][0].key?("articles") && !response["sections"][0]["sections"][0]["articles"].blank?
    #   @chapters = response["sections"][0]["sections"] + @chapters
    # end
    # if response["sections"][0]["sections"][0]["sections"][0].key?("articles") && !response["sections"][0]["sections"][0]["sections"][0]["articles"].blank?
    #   @chapters = response["sections"][0]["sections"][0]["sections"] + @chapters
    # end

    @chapters.compact_blank
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
