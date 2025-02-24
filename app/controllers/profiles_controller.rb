class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    if @user.github_token
      client = Octokit::Client.new(access_token: @user.github_token)
      @latest_events = client.user_events(@user.github_username)
      @latest_commit = @latest_events.find { |event| event.type == "PushEvent" }&.payload&.commits&.first
      
      # Get user's repositories
      @repositories = client.repositories
    end
  rescue Octokit::Error => e
    flash.now[:alert] = "Could not fetch GitHub activity: #{e.message}"
  end
end 