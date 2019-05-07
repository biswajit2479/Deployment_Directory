class HomeController < ApplicationController
  def show
    if current_user
      redirect_to companies_path
    end
  end
end
