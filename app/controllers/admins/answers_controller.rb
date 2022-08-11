# frozen_string_literal: true

module Admins
  class AnswersController < AdminsController
    before_action :set_question
    def create
      @answer = @question.answers.build(answer_params)

      if @answer.save
        AnswerMailer.with(user: current_user, answer: @answer, question: @question).question_answered.deliver_later
        redirect_to admins_question_path(@question), notice: 'Answer created!'
      else
        @answers = @question.answers.all
        render 'admins/questions/show'
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

    def set_question
      @question = Question.find(params[:question_id])
    end
  end
end
