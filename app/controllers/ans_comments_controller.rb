class AnsCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    @ans_comments = @answer.ans_comments
    @ans_comment = AnsComment.new(ans_comment_params)
    if @ans_comment.save
      AnsCommentChannel.broadcast_to @answer, { ans_comment: @ans_comment, user: @ans_comment.user, ans_comments: @ans_comments }
    end
  end

  private

  def ans_comment_params
    params.require(:ans_comment).permit(:ans_c_text).merge(user_id: current_user.id, answer_id: @answer.id)
  end
end
