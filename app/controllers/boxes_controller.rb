class BoxesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :report]

  def show
    @box = Box.find(params[:id])
  end

  def create
    @user = User.find_by_api_key params[:api_key]

    if @user
      @box = Box.create(name: params[:name], user: @user)
      render :json => { box_id: @box.id }
    else
      render :json => { error: "Invalid api key" }
    end
  end

  def report
    @user = User.find_by_api_key params[:api_key]

    if @user
      @box = Box.find(params[:id])
      data_point = DataPoint.new(box: @box, data_type: params[:type], value: params[:value])
      @box.data_points << data_point
      render :json => { result: "success" }
    else
      render :json => { result: "fail", error: "Invalid api key" }
    end
  end

  def update
    @box = Box.find params[:id]
    if @box.update_attributes params[:box]
      redirect_to box_url @box
    else
      redirect_to root_url
    end
  end
end
