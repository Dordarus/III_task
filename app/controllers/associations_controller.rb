class AssociationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_topic_params

    def update       
        @topic.books << @book
        redirect_to topic_path(@topic)
    end

    def destroy
        @topic.books.delete(@book)
        redirect_to topic_path(@topic)
    end

private

    def set_topic_params
        @topic = Topic.find(params[:books_topic][:topic_id])
        @book = Book.find(params[:books_topic][:book_id])
    end
end
