class AnswersController < ApplicationController
  before_action :authorize_admin, except: [:new, :create]

  def new

    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @answer = Answer.new

  end

  def show
    @survey = Survey.find(params[:survey_id])
    @answer = survey.answers.new(answer_params)
  end

  def index
    @surveys = Survey.find(params[:survey_id])
    @answers = @survey.answers
  end

  def create
    survey = Survey.find(params[:survey_id])
    @answer = survey.answers.new(answer_params)
    if @answer.save
      flash[:notice] = 'Thank you for taking our survey!'
      redirect_to survey_path(survey)
    else
      @survey = Survey.find(@answer.survey_id)
      @answers = @survey.answers
      flash[:notice] = @answer.errors.full_messages.join(". ")
      render :'answers/user'
    end
  end



  private

  def answer_params
    params.require(:answer).permit(:answer, :selection, :rating_answer )
  end

  def survey
    @survey ||= Survey.find(params[:survey_id])
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
