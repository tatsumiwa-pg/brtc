class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
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
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @reviews = @user.reviews
    @consultations = @user.consultations.preload(:reconciliation)
    @answers = @user.answers.preload(:review)
  end

  def default
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @consultations = @user.consultations.preload(:reconciliation)
    @answers = @user.answers.preload(:review)
    redirect_to profile_path(@user.profile.id) and return if @user.profile.present?
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  private

  def check_params
    @params = params[:profile]
    ids = [@params[:age_id], @params[:family_type_id], @params[:house_env_id]]
    others = [
      @params[:job],
      @params[:skills],
      @params[:address],
      @params[:cat_exp],
      @params[:my_cats],
      @params[:introduction],
      @params[:user_image]
    ]

    if ids.all? { |id| id == '1' }
      others.all?(&:blank?) ? false : true
    else
      true
    end
  end

  def profile_params
    @params[:job] = '未記入' if @params[:job].blank?
    @params[:skills] = '未記入' if @params[:skills].blank?
    @params[:address] = '未記入' if @params[:address].blank?
    @params[:cat_exp] = '未記入' if @params[:cat_exp].blank?
    @params[:my_cats] = '未記入' if @params[:my_cats].blank?
    @params[:introduction] = '未記入' if @params[:introduction].blank?

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
