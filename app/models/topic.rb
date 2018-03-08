class Topic < ApplicationRecord
    belongs_to :user
    has_many :books_topics
    has_many :books, :through => :books_topics

    before_save do
        title.capitalize!
    end

    validates :title, presence: true, length: {maximum: 30},
                    uniqueness: { case_sensitive: false }
    validates :description, presence: true, length: {maximum: 255}

    def belongs_to?(user)
        self.user == user
    end
end
