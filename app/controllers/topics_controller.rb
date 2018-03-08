class TopicsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show] 
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:new, :create]
  before_action :topic_owner?, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to user_path(current_user), flash: {success: 'Topic was successfully created.'} }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to user_path(current_user), flash: {success: 'Topic was successfully updated.'}}
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), flash: {danger: 'Topic was successfully deleted.'} }
      format.json { head :no_content }
    end
  end

  private

  def topic_owner?
    unless set_topic.belongs_to?(current_user) 
      then redirect_to user_path(current_user), 
      flash: {danger: "You aren't the owner of the book. You can't make any changes"} 
    end
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end