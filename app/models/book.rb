class Book < ApplicationRecord
    belongs_to :user
    has_many :books_topics
    has_many :topics, :through => :books_topics, dependent: :destroy
    #-----options-------
    before_save do
        title.capitalize!
        genre.downcase!
    end
    #-----validates------
    validates :title, presence: true, length: {maximum: 30},
                    uniqueness: { case_sensitive: false }
    validates :genre, presence: true, length: {maximum: 30}
    validates :year, presence: true,
                    numericality: { greater_than_or_equal_to: 0, 
                                less_than_or_equal_to: 9999,
                                only_integer: true}
    validates :plot, presence: true, length: {maximum: 255}

    def belongs_to?(user)
        self.user == user
    end
end
