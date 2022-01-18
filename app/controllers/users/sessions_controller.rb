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
    # Email空白入力の場合は同ページへリダイレクト
    if params[:user].blank?
      flash[:alert] = 'Sorry. But input your Email again'
      redirect_to new_user_session_path
    elsif params[:user][:email].blank?
      flash[:alert] = "Email can't be blank"
      redirect_to new_user_session_path
    else
      # テーブル上の該当ユーザーの有無で分岐
      user = User.find_by(email: params[:user][:email])
      if user.nil?
        flash[:alert] = "Your account could't find"
        render :new
      elsif user.valid_password?(params[:user][:password]) && user.deleted_at.nil?
        # 過去に削除されたアカウントの場合か否かで分岐
        sign_in user
        redirect_to root_path
      else
        flash[:alert] = 'Failed to log-in.'
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
