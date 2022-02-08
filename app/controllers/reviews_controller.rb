class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :refuse_review

  def create
    @review = Review.find_or_initialize_by(answer_id: @answer.id)
    render json: { review: @review } if @review.update(review_params)
  end

  private

  def review_params
    params.require(:review).permit(:point).merge(user_id: current_user.id, answer_id: @answer.id)
  end

  def refuse_review
    @answer = Answer.find(params[:answer_id])
    @consultation = Consultation.find_by(id: @answer.consultation_id)
    redirect_to redirect_to answer_path(@answer.id) unless current_user.id == @consultation.user_id
  end
end
