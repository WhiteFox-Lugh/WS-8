# frozen_string_literal: true

class QuestionController < ApplicationController
  def index; end

  def new
    @lesson = Lesson.find(params[:id])
    @course = Course.find(@lesson.course_id)
    @question = Question.new
    @array = Bar.where(lesson_id: params[:id])
    @pages = @array.pluck(:page)
    # binding.pry
  end

  def create
    @question = Question.new(question_params)
    # binding.pry
    if params[:submit] == 'preview'
      render :action => 'new'
    elsif @question.save
      redirect_to question_list_path, notice: 'Posted Successfully!'
    else
      flash[:alert] = @question.errors
      redirect_to "/question/post_question/#{params[:id]}/new"
    end
  end

  def list
    @lesson = Lesson.find(params[:id])
    @questions = Question.where(lesson_id: params[:id]).page(params[:page]).per(10)
    @course = Course.find(@lesson.course_id)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_id, :lesson_id, :page)
  end
end
