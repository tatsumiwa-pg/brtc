class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path
  end

  def new
    @profile = Profile.new
    render :layout => 'users'
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def profile_params
    params[:profile][:job] = '未記入' if params[:profile][:job].blank?
    params[:profile][:skills] = '未記入' if params[:profile][:skills].blank?
    params[:profile][:address] = '未記入' if params[:profile][:address].blank?
    params[:profile][:cat_exp] = '未記入' if params[:profile][:cat_exp].blank?
    params[:profile][:my_cats] = '未記入' if params[:profile][:my_cats].blank?
    params[:profile][:introduction] = '未記入' if params[:profile][:introduction].blank?

    binding.pry
    params.require(:profile).permit(
      :age_id,
      :job,
      :skills,
      :address,
      :cat_exp,
      :family_type_id,
      :house_env_id,
      :my_cats,
      :introduction,
      :user_image
    ).merge(user_id: current_user.id)
  end
end
