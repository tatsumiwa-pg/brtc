class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @consultation = Consultation.find(params[:consultation_id])
    @answer = Answer.new
  end

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to consultation_path(@consultation.id)
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:ans_title, :ans_text, :image).merge(user_id: current_user.id, consultation_id: @consultation.id)
  end
end
