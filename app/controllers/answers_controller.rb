class AnswersController < ApplicationController
  before_action :authenticate_user!, except: :show
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
    @consultation = @answer.consultation
    @ans_comment = AnsComment.new
    @ans_comments = @answer.ans_comments.preload(user: :profile).order('created_at DESC')
    @review = Review.new
  end

  private

  def set_consultation
    @consultation = Consultation.find(params[:consultation_id])
  end

  def answer_params
    params.require(:answer).permit(
      :ans_title,
      :ans_text,
      :ans_image
    ).merge(user_id: current_user.id, consultation_id: @consultation.id)
  end

  def refuse_answer
    if current_user.id == @consultation.user_id || @consultation.reconciliation.present?
      redirect_to consultation_path(@consultation.id)
    end
  end
end
