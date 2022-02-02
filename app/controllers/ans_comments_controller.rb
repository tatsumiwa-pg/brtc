class AnsCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    @ans_comment = AnsComment.new(ans_comment_params)
    if @ans_comment.save
      redirect_to answer_path(@answer.id)
    end
  end

  private

  def ans_comment_params
    params.require(:ans_comment).permit(:ans_c_text).merge(user_id: current_user.id, answer_id: @answer.id)
  end
end
