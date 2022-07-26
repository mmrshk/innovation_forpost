# frozen_string_literal: true

class QuestionsController < ApplicationController
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
    @question = Question.find_by(id: params[:id])
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy
    redirect_to questions_path, notice: 'Question destroyed'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_name, :user_email)
  end
end
