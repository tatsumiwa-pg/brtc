class ReconciliationsController < ApplicationController
  def index
  end

  def new
    @consultation = Consultation.find(params[:consultation_id])
    @reconciliation = Reconciliation.new
  end

  def create
  end
end
