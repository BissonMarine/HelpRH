class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result ]

  def home
    @relation = Conv::CONVENTIONS_ID
  end

  def search
  end

  def result
  end

end
