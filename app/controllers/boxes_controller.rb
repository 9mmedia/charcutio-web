class BoxesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :report]

  before_filter :authorize_api, only: [:create, :report, :set_points]

  def show
    @box = Box.find(params[:id])
  end

  def create
    @box = Box.create(name: params[:name], user: @user)
    render :json => { box_id: @box.id }
  end

  def report
    @box = Box.find(params[:id])
    data_point = DataPoint.new(box: @box, data_type: params[:type], value: params[:value])
    @box.data_points << data_point
    render :json => { result: "success" }
  end

  def set_points
    render :json => @box.get_set_points
  end

  def update
    @box = Box.find params[:id]
    if @box.update_attributes params[:box]
      redirect_to box_url @box
    else
      redirect_to root_url
    end
  end

  def data
    @box = Box.find params[:id]
    data_points = @box.data_points.where(data_type: params[:type])
    data = data_points.map { |datum| {time: datum.created_at.to_i, value: datum.value} }
    render :json => { type: params[:type], data: data }
  end

  private

    def authorize_api
      @user = User.find_by_api_key params[:api_key]
      render :json => { error: "Invalid api key" } unless @user
    end
end
