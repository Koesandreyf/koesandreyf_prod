class TurbolyappsController < ApplicationController
  def new
  end

  def index
    get_data = Turbolyapp.all
    get_task = Turbolyapp.check_date(get_data)
    @task_todo = nil

    if get_task.present?
      title_task = get_task.map{ |title_task| title_task.title }
      title_task = title_task.join(',')
      @task_todo =  "Alert you have Task todo #{title_task} for today"
    end
    
    @turboly = get_data
  end

  def create
    @turboly = Turbolyapp.new(turboly_params)
    if Turbolyapp.check_data(@turboly)
      if @turboly.save
        redirect_to @turboly
      end
    else
      render 'new'
    end
  end

  def show
    @turboly = Turbolyapp.find(params[:id])
  end

  def destroy
    @turboly = Turbolyapp.find(params[:id])

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
