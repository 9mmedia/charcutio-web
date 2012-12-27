class BoxesController < ApplicationController
  def show
    @box = Box.find(params[:id])
  end

  def create
    @user = User.where(api_key: params[:api_key]).first

    if @user
      @box = Box.create(name: params[:name], user: @user)
      render :json => { box_id: @box.id }
    else
      render :json => { error: "Invalid api key" }
    end
  end

  def report
    @user = User.where(api_key: params[:api_key]).first

    if @user
      @box = Box.find(params[:id])
      data_point = DataPoint.new(box: @box, data_type: params[:type], value: params[:value])
      @box.data_points << data_point
      render :json => { result: "success" }
    else
      render :json => { result: "fail", error: "Invalid api key" }
    end
  end
end
