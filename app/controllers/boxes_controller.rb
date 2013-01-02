class BoxesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :photo, :report, :set_points]

  before_filter :authenticate_user!, only: [:update]
  before_filter :authorize_api, only: [:create, :photo, :report, :set_points]
  before_filter :find_box, except: :create

  def create
    @box = Box.create(name: params[:name], user: @user)
    render :json => { box_id: @box.id }
  end

  def edit
  end

  def photo
    @box.tweet params[:image_file]
    head :ok
  end

  def report
    data_point = DataPoint.new(box: @box, data_type: params[:type], value: params[:value])
    @box.update_data_points data_point
    render :json => { result: "success" }
  end

  def set_points
    render :json => @box.get_set_points
  end

  def show
  end

  def update
    if @box.update_attributes params[:box]
      redirect_to box_url @box
    else
      redirect_to root_url
    end
  end

  def data
    span = params[:span] || :day
    data_points = @box.data_for(params[:type], span.to_sym)
    data = data_points.map { |datum| {time: datum.created_at.to_i, value: datum.value} }
    render :json => { type: params[:type], data: data }
  end

  private

    def authorize_api
      @user = User.find_by_api_key params[:api_key]
      render :json => { error: "Invalid api key" } unless @user
    end

    def find_box
      @box = Box.find params[:id]
    end
end
