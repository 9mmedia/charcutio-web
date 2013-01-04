class TeamsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_team, except: :create
  before_filter :authenticate_teammate, only: :update

  def create
    if @team = current_user.teams.create!(params[:team])
      redirect_to team_url @team
    else
      redirect_to root_url
    end
  end

  def show
  end

  def update
    if @team.update_attributes(params[:team])
      redirect_to team_url @team
    else
      redirect_to root_url
    end
  end

  private

    def authenticate_teammate
      redirect_to root_url unless current_user.teams.include?(@team)
    end

    def find_team
      @team = Team.find params[:id]
      redirect_to root_url unless @team
    end
end
