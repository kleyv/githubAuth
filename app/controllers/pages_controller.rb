class PagesController < ApplicationController
  def home
    redirect_to profile_path if user_signed_in?
  end
end 