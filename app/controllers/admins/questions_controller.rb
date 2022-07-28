# frozen_string_literal: true

module Admins
  class QuestionsController < AdminsController
    before_action :question, only: %i[edit update destroy show]
    def index
      @questions = Question.all
    end

    def show; end

    def edit
      # @question = Question.find_by(id: params[:id])
    end

    # def update
    # @question = Question.find_by(id: params[:id])
    # if @question.update question_params
    #  redirect_to admins_questions_path
    # else
    # render :edit, status: :unprocessable_entity
    # end
    # end
    def update
      unless current_user.role_super_admin? || current_user.role_admin?
        redirect_to admins_questions_path, notice: 'Access denied!' # remove this notice in the future
        return
      end
      if @question.update(question_params)
        redirect_to admins_questions_path, notice: 'Question updated!'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      unless current_user.role_super_admin? || current_user.role_admin?
        redirect_to admins_questions_path, notice: 'Access denied!' # remove this notice in the future
        return
      end
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
