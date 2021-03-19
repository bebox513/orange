class CareDiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_role?

  def index
    cd_date = params[:cd_date]
    if cd_date.present?
      @cd_date = cd_date.to_date
      @care_diaries = current_user.care_diaries.where(date: @cd_date.beginning_of_month..@cd_date.end_of_month).order(date: "ASC")
    else
      @care_diary = current_user.care_diaries.order(date: :desc).first
      if @care_diary.present?
        @cd_date = @care_diary.date
        @care_diaries = current_user.care_diaries.where(date: @cd_date.beginning_of_month..@cd_date.end_of_month).order(date: "ASC")
      end
    end
  end

  def show
    @care_diary = CareDiary.find(params[:id])
  end

  def new
    @date = Date.today
    @care_diary = CareDiary.new
  end

  def create
    @care_diary = CareDiary.new(care_diary_params)
    if @care_diary.save
      redirect_to "/care_diaries"
    else
      redirect_to "/care_diaries/new"
    end
  end

  def edit
    @care_diary = CareDiary.find(params[:id])
  end

  def update
    @care_diary = CareDiary.find(params[:id])
    @care_diary.update(care_diary_params)
    redirect_to "/care_diaries/#{params[:id]}"
  end

  def destroy
    care_diary = CareDiary.find(params[:id])
    care_diary.destroy
    redirect_to care_diaries_path

  end

  private
  def user_role?
    if current_user.role != 1
      redirect_to "/"
    end
  end


  def care_diary_params
    params.require(:care_diary).permit(:notes, :temperature, :date, :breakfast_meal_intake, :lunch_meal_intake, :dinner_meal_intake, :user_id, :name)
  end
end
