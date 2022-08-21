# frozen_string_literal: true

module Admins
  class AnswersController < AdminsController
    before_action :question
    def create
      @answer = @question.answers.build(answer_params)

      if @answer.save
        AnswerMailer.with(answer: @answer, question: @question, admin: current_user).question_answered.deliver_later
        redirect_to admins_question_path(@question), notice: 'Answer created!'
      else
        redirect_to admins_question_path(@question), notice: 'Error, something goes wrong'
      end
    end

    def destroy
      answer = @question.answers.find(params[:id])
      if answer.destroy
        redirect_to admins_question_path, notice: 'Answer destroyed!'
      else
        flash[:notice] = 'Error, something goes wrong'
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:body)
    end

    def question
      @question ||= Question.find(params[:question_id])
    end
  end
end