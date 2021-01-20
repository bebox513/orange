class CareDiariesController < ApplicationController
  def index
    cd_next_date = params[:cd_next_date]
    cd_back_date = params[:cd_back_date]
    #if文で「次の月へ」ボタン　or 「前の月へ」ボタンからなにも送られてきていなかった場合true」
    if cd_next_date.present?
      #「次の月へ」ボタンから受け取った値に「+1」してその月のデータを取得
      @cd_date = cd_next_date.to_date
      @care_diaries = current_user.care_diaries.where(date: @cd_date.beginning_of_month..@cd_date.end_of_month).order(date: "ASC")
    elsif cd_back_date.present?
      #「前の月へ」ボタンから受け取った値に「-1」してその月のデータを取得
      @cd_date = cd_back_date.to_date
      @care_diaries = current_user.care_diaries.where(date: @cd_date.beginning_of_month..@cd_date.end_of_month).order(date: "ASC")
    else
      #最新の日付のレコードを取得してその月のレコードを取得
      @care_diary = current_user.care_diaries.order(date: :desc).first
      @cd_date = @care_diary.date
      @care_diaries = current_user.care_diaries.where(date: @cd_date.beginning_of_month..@cd_date.end_of_month).order(date: "ASC")
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

  private
  def care_diary_params
    params.require(:care_diary).permit(:notes, :temperature, :date, :breakfast_meal_intake, :lunch_meal_intake, :dinner_meal_intake, :user_id, :name)
  end
end
