class CareRecipientsController < ApplicationController

  def index
    @care_recipients = current_user.care_recipients.all

  end

  def new
    @care_recipient = CareRecipient.new
  end

  def create
    if CareRecipient.create(params_int(care_recipient_params))
      redirect_to "/care_recipients"
    else
      redirect_to "/care_recipient/new"
    end
  end

  def show
    @care_recipient = CareRecipient.find(params[:id])
  end

  def edit
    @care_recipient = CareRecipient.find(params[:id])
  end

  def update
    @care_recipient = CareRecipient.find(params[:id])
    if @care_recipient.update(params_int(care_recipient_params))
      redirect_to "/care_recipients/#{params[:id]}"
    else
      redirect_to "/care_recipients/#{params[:id]}/edit"
    end
  end

  def destroy
    care_recipient = CareRecipient.find(params[:id])
    care_recipient.destroy
  end

  def search
    if params[:name].present?
      @care_recipients = CareRecipient.where('name LIKE ?', "%#{params[:name]}%")
    else
      @care_recipients = CareRecipient.none
    end
  end

  private
  def care_recipient_params
    params.require(:care_recipient).permit(
      :name,
      :sex,
      :birthday,
      :age,
      :degree_care_required,
      :facility_in_charge,
      :manager_in_charge,
      :dementia,
      :notes,
      :user_id
    )
  end

  def params_int(care_recipient_params)
    care_recipient_params.each do |key,value|
      if integer_string?(value)
        care_recipient_params[key]=value.to_i
      end
    end
  end
end
