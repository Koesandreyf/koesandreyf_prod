class TurbolyappsController < ApplicationController
  def new
  end

  def index
    get_data = Turbolyapp.all
    @task_todo = nil
    all_data_by_user = []

    get_data.each do |data|
      if data.user_id == current_user.id
        all_data_by_user << data
      end
    end
    
    check_date(all_data_by_user)
    @turboly = all_data_by_user
  end

  def check_date(all_data_by_user)
    get_task = Turbolyapp.check_date(all_data_by_user)

    if get_task.present?
      title_task = get_task.map{ |title_task| title_task.title }
      title_task = title_task.join(',')
      @task_todo =  "You have Task to do #{title_task} for today"
    end
  end

  def create
    @turboly = Turbolyapp.new(turboly_params)

    if !@turboly.user_id.present?
      @turboly.user_id = current_user.id
    end

    if Turbolyapp.check_data(@turboly)
      if @turboly.save
        redirect_to @turboly
      end
    else
      render 'new'
    end
  end

  def show
    if Turbolyapp.find(params[:id]).user_id.present? &&
      Turbolyapp.find(params[:id]).user_id == current_user.id
      @turboly = Turbolyapp.find(params[:id])
    end
  end

  def destroy
    if Turbolyapp.find(params[:id]).user_id.present? &&
      Turbolyapp.find(params[:id]).user_id == current_user.id
      @turboly = Turbolyapp.find(params[:id])
    end

    if @turboly.present?
      @turboly.destroy
    end

    redirect_to turbolyapps_path
  end

  private
    def turboly_params
      params.require(:turbolyapp).permit(:title, :text, :date)
    end
end
