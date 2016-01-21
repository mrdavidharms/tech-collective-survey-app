class SurveysController < ApplicationController
  before_action :authorize_admin, except: [:index, :show]

  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
    @question = Question.new
    @questions = @survey.questions
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.admin = current_admin
    if @survey.save
      flash[:notice] = "Survey Added Successfully"
      redirect_to surveys_path
    else
      flash.now[:errors] = @survey.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(survey_params)
      flash[:notice] = "Survey edited successfully"
      redirect_to root_path
    else
      flash[:errors] = @survey.errors.full_messages.join(". ")
      render :edit
    end
  end

  protected

  def survey_params
    params.require(:survey).permit(:title, :group)
  end

  def authorize_admin
    if !admin_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
