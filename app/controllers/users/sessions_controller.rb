# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  layout 'users'

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if params[:user][:email].blank?
      flash[:alert] = "Email can't be blank"
      @user = User.new
      render :new
    else
      # テーブル上の該当ユーザーの有無で分岐
      user = User.find_by(email: params[:user][:email])
      email = params[:user][:email]
      if user.nil?
        flash[:alert] = "Your account could't find"
        @user = User.new(email: email)
        render :new
      elsif user.valid_password?(params[:user][:password]) && user.deleted_at.nil?
        # 過去に削除されたアカウントの場合か否かで分岐
        sign_in user
        redirect_back(fallback_location: root_path)
      else
        flash[:alert] = 'Failed to log-in. Check your password, please'
        @user = User.new(email: email)
        render :new
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
