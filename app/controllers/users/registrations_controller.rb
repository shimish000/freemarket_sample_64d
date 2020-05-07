# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end
  
  # POST /resource
  def create
    def create
      if params[:sns_auth] == 'true'
        pass = Devise.friendly_token
        params[:user][:password] = pass
        params[:user][:password_confirmation] = pass
      end
      super
    end
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @phone = @user.build_phone
    render :new_phone
  end

  def create_phone
    @user = User.new(session["devise.regist_data"]["user"])
    @phone = Phone.new(phone_params)
    unless @phone.valid?
      flash.now[:alert] = @phone.errors.full_messages
      render :new_phone and return
    end
    @user.build_phone(@phone.attributes)
    @user.save!
    sign_in(:user, @user)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :birth_year_id, :birth_month_id, :birth_day_id, :nickname])
  end

  def phone_params
    params.require(:phone).permit(:phone)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


end
