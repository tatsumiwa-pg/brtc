class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consultation, only: [:index, :new, :create]
  before_action :refuse_answer, only: [:new, :create]

  def index
    redirect_to consultation_path(@consultation.id)
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to consultation_path(@consultation.id)
    else
      render :new
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @consultation = Consultation.find_by(id: @answer.consultation_id)
  end

  private

  def set_consultation
    @consultation = Consultation.find(params[:consultation_id])
  end

  def answer_params
    params.require(:answer).permit(:ans_title, :ans_text, :ans_image).merge(user_id: current_user.id,
                                                                            consultation_id: @consultation.id)
  end

  def refuse_answer
    redirect_to consultation_path(@consultation.id) if current_user.id == @consultation.user_id || @consultation.reconciliation.present?
  end
end
