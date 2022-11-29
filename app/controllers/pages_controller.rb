class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :search, :result ]

  def home
  end

  def search
  end

  def result

  end
end
