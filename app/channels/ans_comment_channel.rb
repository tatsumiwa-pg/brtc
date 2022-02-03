class AnsCommentChannel < ApplicationCable::Channel
  def subscribed
    @answer = Answer.find(params[:answer_id])
    stream_for @answer
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
