class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @consultations = Consultation.includes(:user).order("updated_at DESC")
  end

  def new
    @consultation = Consultation.new
  end

  def create
    @consultation = Consultation.new(consultation_params)
    if @consultation.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
  end

  private

  def consultation_params
    params.require(:consultation).permit(:cons_title, :category_id, :summary, :situation, :problem, :image).merge(user_id: current_user.id)
  end
end
