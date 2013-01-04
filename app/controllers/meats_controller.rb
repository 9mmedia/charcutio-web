class MeatsController < ApplicationController

  before_filter :authenticate_user!, except: :show
  before_filter :find_meat, only: [:edit, :show, :update]
  before_filter :authenticate_teammate, only: [:edit, :update]

  def create
    if @meat = current_user.meats.create!(params[:meat])
      redirect_to meat_url @meat
    else
      redirect_to root_url
    end
  end

  def edit
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

  private

    def authenticate_teammate
      unless current_user.has_meat_authority?(@meat)
        redirect_to root_url
      end
    end

    def find_meat
      @meat = Meat.find params[:id]
      redirect_to root_url unless @meat
    end
end
