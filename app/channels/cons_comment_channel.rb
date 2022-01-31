class ConsCommentChannel < ApplicationCable::Channel
  def subscribed
    @consultation = Consultation.find(params[:consultation_id])
    stream_for @consultation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
