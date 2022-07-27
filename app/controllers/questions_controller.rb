# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :set_question!, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Question created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc)
  end

  def edit; end

  def update
    unless current_user.role_super_admin? || current_user.role_admin?
      redirect_to questions_path, notice: 'Access denied!'
      return
    end
    if @question.update(question_params)
      redirect_to questions_path, notice: 'Question updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless current_user.role_super_admin? || current_user.role_admin?
      flash[:alert] = 'Access denied'
      redirect_to questions_path, notice: 'Access denied!'
      return
    end
    redirect_to questions_path, notice: 'Question destroyed!' if @question.destroy
  end

  private

  def set_question!
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_name, :user_email)
  end
end
