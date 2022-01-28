class ReconciliationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consultation


  def index
  end

  def new
    @reconciliation = Reconciliation.new
  end

  def create
    @reconciliation = Reconciliation.new(reconciliation_params)
    if @consultation.reconciliation.nil?
      @reconciliation.save
      redirect_to consultation_path(@consultation.id)
    else
      redirect_to consultation_path(@consultation.id), alert: "This consultation already have reconciliation! 既に和解済みの相談です"
    end
  end

  private

  def set_consultation
    @consultation = Consultation.find(params[:consultation_id])
  end

  def reconciliation_params
    params[:reconciliation][:rec_text] = 'ありがとうございました' if params[:reconciliation][:rec_text].empty?
    params.require(:reconciliation).permit(:rec_text).merge(consultation_id: @consultation.id)
  end


end
