class ConsultationsController < ApplicationController
  def index
  end

  def new
    @consultation = Consultation.new
  end
end
