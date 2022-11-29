class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result ]

  def home
  end

  def search
  end

  def result
    header = {
      "client_id": "57bfb2ae-eab4-4cb0-bdb1-7ca1d734a3e5",
      "client_secret": "f5baae2e-9989-4ee4-ba75-b183610959f0",
      "id": "KALICONT000005635384",
      "searchedString": "constitution 1958"
    }
    api_url = "https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliCont"
    # @response = HTTParty.get(url: api_url, header: header)
    # @response = HTTParty.post(url: api_url, body: body, headers: { 'Content-Type' => 'application/json' })
    # @response = HTTParty.post(url: api_url, header: header)
    # @response = HTTParty.post(url: api_url, headers: { header: header, 'Content-Type' => 'application/json' })
    @response = HTTParty.post(url: api_url, headers: { header: header, 'Content-Type' => 'application/json' })

  end

  def tryresult

    # @cfg = 'xxxsupport'
    @user_key = '57bfb2ae-eab4-4cb0-bdb1-7ca1d734a3e5'
    @client_secret = 'f5baae2e-9989-4ee4-ba75-b183610959f0'
    # @project = 'excelm-manoke'
    @url_new_string = 'https://sandbox-api.piste.gouv.fr/dila/legifrance-beta/lf-engine-app/consult/kaliCont'
    response =  HTTParty.get(@url_new_string.to_str)  #submit the string to get the token
    @parsed_and_a_hash = JSON.parse(response)
    @token = @parsed_and_a_hash["token"]


    #make a new string with the token

    @urlstring_to_post = 'https://api.squishlist.com/rest/?cfg='+@cfg+'&token='+@token+'&method=squish.issue.submit&prj='+@project

    #submit and get a result

    @result = HTTParty.post(@urlstring_to_post.to_str, :body => {:subject => 'This is the screen name', :issue_type => 'Application Problem', :status => 'Open', :priority => 'Normal', :description => 'This is the description for the problem'})
  end

  private

  def searching_url
  end

end
