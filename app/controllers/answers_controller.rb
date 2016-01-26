class AnswersController < ApplicationController
  before_action :authorize_admin, except: [:create]

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def show
    binding.pry

    @question = Question.find(params[:question_id])
    @answer = question.answers.new(answer_params)
  end

  def index
    @questions = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def create
    question = Question.find(params[:question_id])

    @answer = question.answers.new(answer_params)
    if @answer.save
      flash[:notice] = 'Thank you for taking our survey!'
      redirect_to question_path(question)
    else
      @question = Question.find(@answer.question_id)
      @answers = @question.answers
      flash[:notice] = @answer.errors.full_messages.join(". ")
      render :'answers/user'
    end
  end



  private

  def answer_params
    params.require(:answer).permit(:answer, :selection, :rating_answer )
  end

  def question
    @question ||= Question.find(params[:question_id])
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
