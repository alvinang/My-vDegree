class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @course = Course.where(user_id: current_user.id)
    @dashboard = Course.new
  end

  def create
    @dashboard = Course.new
    @dashboard.user_id = current_user.id
    @dashboard.name = params[:course][:name]
    @dashboard.url = params[:course][:url]
    @dashboard.start_date = params[:course][:start_date]
    @dashboard.end_date = params[:course][:end_date]
    @dashboard.save
    redirect_to root_path
  end

end
