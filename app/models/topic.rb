class Topic < ApplicationRecord
    belongs_to :user
    has_many :books_topics
    has_many :books, :through => :books_topics
end
