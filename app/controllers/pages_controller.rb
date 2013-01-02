class PagesController < ApplicationController
  def home
    @team = Team.new
  end
end
