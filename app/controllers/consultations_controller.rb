class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_consultation, only: [:show, :edit, :update, :destroy]
  before_action :move_to_details_page, only: [:edit, :destroy]

  def index
    @consultations = Consultation.left_joins(:reconciliation).where(
      reconciliations: { consultation_id: nil }
    ).preload([user: :profile], :answers).order('updated_at DESC')
    @reconciled_consultations = Consultation.joins(:reconciliation).where.not(
      reconciliations: { consultation_id: nil }
    ).preload([user: :profile], :answers).order('updated_at DESC')
  end

  def new
    @consultation = Consultation.new
  end

  def create
    @consultation = Consultation.new(consultation_params)
    if @consultation.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @answers = @consultation.answers.preload([user: :profile], :review).order('updated_at DESC')
    @cons_comment = ConsComment.new
    @cons_comments = @consultation.cons_comments.preload(user: :profile).order('created_at DESC')
  end

  def edit
  end

  def update
    if @consultation.update(consultation_params)
      redirect_to consultation_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @consultation.destroy
    redirect_to root_path
  end

  private

  def consultation_params
    params.require(:consultation).permit(
      :cons_title,
      :category_id,
      :summary,
      :situation,
      :problem,
      :cons_image
    ).merge(user_id: current_user.id)
  end

  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

  def move_to_details_page
    if current_user.id != @consultation.user.id || @consultation.reconciliation.present?
      redirect_to consultation_path(@consultation.id)
    end
  end
end
