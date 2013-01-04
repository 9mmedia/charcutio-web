class BoxesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :photo, :report, :set_points]

  before_filter :authenticate_user!, only: [:edit, :update]
  before_filter :authorize_api, only: [:create, :photo, :report, :set_points]
  before_filter :find_box, except: :create
  before_filter :authenticate_box_owner, only: [:edit, :update]

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
    data_point = DataPoint.create!(box: @box, data_type: params[:type], value: params[:value])
    @box.data_points << data_point
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
    data = []
    span = params[:span] || :day
    relay_types = DataPoint::RELAY_TYPES[params[:type].to_sym]
    @box.data_for(params[:type], span.to_sym).map do |datum|
      if data.empty? || data[-1][:time] != datum.created_at.to_i
        data << {time: datum.created_at.to_i, value: nil, relay0: nil, relay1: nil}
      end
      data[-1][:value] ||= datum.value if datum.data_type == params[:type]
      if relay_types
        data[-1][:relay0] ||= datum.value if datum.data_type == relay_types[0]
        data[-1][:relay1] ||= datum.value if datum.data_type == relay_types[1]
      end
    end
    render :json => { type: params[:type], data: data }
  end

  private

    def authorize_api
      @user = User.find_by_api_key params[:api_key]
      render :json => { error: "Invalid api key" } unless @user
    end

    def authenticate_box_owner
      unless current_user == @box.user || current_user.boxes.include?(@box)
        redirect_to root_url
      end
    end

    def find_box
      @box = Box.find params[:id]
    end
end
