class QuestionsController < ApplicationController
  before_action :authorize_admin, except: [:index, :show]
  before_action :survey

  def new
    @question = Question.new
  end

  def show
    survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
  end

  def index
    if admin_signed_in?
    survey = Survey.find(params[:survey_id])
    @questions = survey.questions
    else admin_signed_in? == false
      survey = Survey.find(params[:survey_id])
      @questions = survey.questions
      @question = @questions.first
      redirect_to new_question_answer_path(@question, @answer)
    end
  end

  def create
    survey = Survey.find(params[:survey_id])
    @question = survey.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question has been successfully added.'
      redirect_to survey_questions_path(survey)
    else
      @survey = Survey.find(@question.survey_id)
      @questions = @survey.questions
      flash[:notice] = @question.errors.full_messages.join(". ")
      redirect_to survey_questions_path(survey)
    end
  end

  def edit
     @survey = Survey.find(params[:survey_id])
     @question = @survey.questions.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:notice] = "Question edited successfully"
      redirect_to survey_questions_path(survey)
    else
      flash[:errors] = @question.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    question.destroy
    flash[:success] = "Question Deleted"
    redirect_to survey_path(survey)
  end

  private

  def question_params
    params.require(:question).permit(:body, :rating, :text, :multiple_choice, :required )
  end

  def survey
    @survey ||= Survey.find(params[:survey_id])
  end

  def question
    @question ||= Question.find(params[:id])
  end

  def authorize_admin
    if !admin_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
