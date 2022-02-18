class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def index
  end

  def new
    redirect_to default_profile_path(current_user.id) and return unless current_user.profile.blank? 
    @profile = Profile.new
    render layout: 'users'
  end

  def create
    if check_params
      @profile = Profile.new(profile_params)
      if @profile.save
        redirect_to root_path and return
      else
        render :new
      end
    end
    redirect_to root_path
  end

  def show
    @user = @profile.user
    @reviews = @user.reviews
    @consultations = @user.consultations.preload(:reconciliation)
    @answers = @user.answers.preload(:review)
  end

  def default
    @user = User.find(params[:id])
    redirect_to profile_path(@user.profile.id) and return if @user.profile.present?
    @reviews = @user.reviews
    @consultations = @user.consultations.preload(:reconciliation)
    @answers = @user.answers.preload(:review)
  end

  def edit
    redirect_to profile_path(@profile.id) if current_user.id != @profile.user_id || current_user.profile.nil?
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.id) and return
    else
      render :new
    end
  end

  private

  def set_profile
    redirect_to root_path and return unless Profile.find_by(id: params[:id]).present? 
    @profile = Profile.find(params[:id])
  end
  
  def check_params
    ids = [ params[:profile][:age_id], params[:profile][:family_type_id], params[:profile][:house_env_id] ]
    others = [
      params[:profile][:job],
      params[:profile][:skills],
      params[:profile][:address],
      params[:profile][:cat_exp],
      params[:profile][:my_cats],
      params[:profile][:introduction],
      params[:profile][:user_image]
    ]

    if ids.all? { |id| id == '1' }
      others.all?(&:blank?) ? false : true
    else
      true
    end
  end

  def profile_params
    params[:profile][:job] = '未記入' if params[:profile][:job].blank?
    params[:profile][:skills] = '未記入' if params[:profile][:skills].blank?
    params[:profile][:address] = '未記入' if params[:profile][:address].blank?
    params[:profile][:cat_exp] = '未記入' if params[:profile][:cat_exp].blank?
    params[:profile][:my_cats] = '未記入' if params[:profile][:my_cats].blank?
    params[:profile][:introduction] = '未記入' if params[:profile][:introduction].blank?

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
