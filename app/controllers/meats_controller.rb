class MeatsController < ApplicationController

  before_filter :authenticate_user!, except: :show

  def create
    if @meat = current_user.meats.create!(params[:meat])
      redirect_to meat_url @meat
    else
      redirect_to root_url
    end
  end

  def new
    @meat = Meat.new
  end

  def show
    @meat = Meat.find params[:id]
  end

  def update
    @meat = Meat.find params[:id]
    if @meat && @meat.update_attributes(params[:meat])
      redirect_to meat_url @meat
    else
      redirect_to root_url
    end
  end
end
