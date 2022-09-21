# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :question, only: %i[show]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path, notice: I18n.t('admins.questions.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_name, :user_email)
  end
end
