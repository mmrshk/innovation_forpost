# frozen_string_literal: true

module Admins
  class QuestionsController < AdminsController
    before_action :question, only: %i[edit update destroy show]
    before_action :authorize_question, only: %i[show edit update destroy]

    def index
      @questions = policy_scope(Question)
    end

    def show
      @answer = @question.answers.build
      @answers = @question.answers.all
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
      if @question.destroy
        redirect_to admins_questions_path, notice: 'Question destroyed!'
      else
        flash[:notice] = 'Error, something goes wrong'
      end
    end

    private

    def question
      @question ||= Question.find(params[:id])
    end

    def authorize_question
      authorize @question
    end

    def question_params
      params.require(:question).permit(:title, :body, :user_name, :user_email)
    end
  end
end
