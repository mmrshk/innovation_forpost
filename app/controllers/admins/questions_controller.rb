# frozen_string_literal: true

module Admins
  class QuestionsController < AdminsController
    before_action :question, only: %i[edit update destroy show]

    def index
      @questions = Question.all
    end

    def show
      @answer = @question.answers.build
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to admins_questions_path, notice: 'Question updated!'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      redirect_to admins_questions_path, notice: 'Question destroyed!' if @question.destroy
    end

    private

    def question
      @question ||= Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :user_name, :user_email)
    end
  end
end
