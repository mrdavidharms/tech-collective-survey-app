class AnswersController < ApplicationController
  before_action :authorize_admin, except: [:new, :create]

  def new
    @question = Question.find(params[:question_id])
    @survey = Survey.find(@question.survey_id)
    @answer = Answer.new
  end

  def show
    question = Question.find(params[:question_id])
    @answer = survey.answers.new(answer_params)
  end

  def index
    @question = Question.find(params[:question_id])
    @survey = Survey.find(@question.survey_id)
    @questions = @survey.questions
    @answers = @survey.answers}
  end

  def create
    @question = Question.find(params[:question_id])
    @survey = Survey.find(@question.survey_id)
    @answer = @question.answers.create(answer_params)
    @answer.survey_id = @survey.id
    @nq = next_question

    if @answer.save && next_question != nil
      flash[:notice] = 'answer saved'
      redirect_to new_question_answer_path(question_id: next_question)
    elsif @answer.save && next_question == nil
      flash[:notice] = "Thank you for taking our survey!"
      redirect_to root_path
    else
      @question = Question.find(@answer.question_id)
      @answers = @question.answers
      flash[:notice] = @answer.errors.full_messages.join(". ")
      redirect_to root_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :selection, :rating_answer, :question_id, :survey_id )
  end

  def current_question
    @question = Question.find(@answer.question_id)
  end

  def next_question
    next_array = []
    @question = Question.find(params[:question_id])
    @questions = Question.where(survey_id: @question.survey_id)

    @questions.to_a.each do |question|
      if question.id > current_question.id
        next_array << question.id
      end
    end
    next_array[0]
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def authorize_admin
    if !admin_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
