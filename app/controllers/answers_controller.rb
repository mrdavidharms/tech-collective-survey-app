class AnswersController < ApplicationController
  before_action :authorize_admin, except: [:new, :create]

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = survey.answers.new(answer_params)
  end

  def index
    @questions = Question.find(params[:question_id])
    @answers = @questions.answers
  end

  def create


  @question = Question.find(params[:question_id])
  @survey = Survey.find(@question.survey_id)
  @answer = @question.answers.create(answer_params)
  @answer.survey_id = @survey.id
    if @answer.save
      flash[:notice] = 'answer saved'
      next_question.each do |nq|
        unless @question.id == nq.id
        redirect_to new_question_answer_path(question_id: next_question)
        else
          flash[:notice] = "Thank you for taking our survey!"
          redirect_to root_path
        end
      end
    else
      @question = Question.find(@answer.question_id)
      @answers = @question.answers
      flash[:notice] = @answer.errors.full_messages.join(". ")
      redirect_to root_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :selection, :rating_answer, :survey_id )
  end

  def next_question
    @questions = Question.where(survey_id: @question.survey_id)
    @questions.to_a.slice!(0)
    @questions.each do |question|
     question.id
    end
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
