require 'benchmark'
class ConsCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @cons_comment = ConsComment.new(cons_comment_params)
    if @cons_comment.save
      ConsCommentChannel.broadcast_to @consultation, { cons_comment: @cons_comment, user: @cons_comment.user }
    end
  end

  private

  def cons_comment_params
    params.require(:cons_comment).permit(:cons_c_text).merge(user_id: current_user.id, consultation_id: @consultation.id)
  end
end
