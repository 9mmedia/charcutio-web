class MeatsController < ApplicationController

  def create
    if @meat = Meat.create(params[:meat])
      redirect_to meat_url @meat
    else
      redirect_to root_url
    end
  end

  def new
    @meat = Meat.new
  end

  def show
    @meat = Meat.find(params[:id])
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