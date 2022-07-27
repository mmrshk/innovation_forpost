# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question!

  def create
    @answer = @question.answers.build(answer_params)
    unless current_user.role_super_admin? || current_user.role_admin?
      @answers = @question.answers.order(created_at: :desc)
      redirect_to question_path(@question), notice: 'Access denied!'
      return
    end

    if @answer.save
      flash[:alert] = 'Answer created!'
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order(created_at: :desc)
      render 'questions/show', status: :unprocessable_entity
    end
  end

  def destroy
    answer = @question.answers.find(params[:id])
    unless current_user.role_super_admin? || current_user.role_admin?
      redirect_to question_path(@question), notice: 'Access denied!'
      return
    end

    redirect_to question_path(@question), notice: 'Answer destroyed' if answer.destroy
  end

  private

  def set_question!
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
