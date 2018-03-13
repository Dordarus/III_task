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
        @topic = Topic.find(book_params[:topic_id])
        @book = Book.find(book_params[:book_id])
    end

    def book_params
        params.require(:books_topic).permit(:topic_id, :book_id)
    end
end
