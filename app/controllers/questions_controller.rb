class QuestionsController < ApplicationController
before_action :authorize_admin, except: [:index, :show]
before_action :survey, only: []

  def new
    @question = Question.new
  end

  def create
      survey = Survey.find(params[:survey_id])
      @question = survey.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question has been successfully added.'
      redirect_to survey_path(survey)
    else
      @survey = Survey.find(@question.survey_id)
      @questions = @survey.questions
      flash[:notice] = @question.errors.full_messages.join(". ")
      render :'surveys/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    question.destroy
    flash[:success] = "Question Deleted"
    redirect_to survey_path(survey)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def survey
    @survey ||= Survey.find(params[:survey_id])
  end

  def authorize_admin
    if !admin_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
