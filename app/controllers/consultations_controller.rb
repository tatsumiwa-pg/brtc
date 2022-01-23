class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_consultation, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit]

  def index
    @consultations = Consultation.includes(:user).order('updated_at DESC')
  end

  def new
    @consultation = Consultation.new
  end

  def create
    @consultation = Consultation.new(consultation_params)
    if @consultation.save
      redirect_to consultation_path(consultation.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @consultation.update(consultation_params)
      redirect_to consultation_path(params[:id])
    else
      render :edit
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:cons_title, :category_id, :summary, :situation, :problem,
                                         :image).merge(user_id: current_user.id)
  end

  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @consultation.user.id
  end
end
