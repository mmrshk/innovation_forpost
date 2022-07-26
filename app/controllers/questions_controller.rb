# frozen_string_literal: true

class QuestionsController < ApplicationController
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
      redirect_to questions_path
    else
      # flash.now[:alert] = 'Error Please check your input'
      render :new
    end
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc)
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question destroyed'
  end

  private

  def set_question!
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_name, :user_email)
  end
end
