class BooksTopic < ApplicationRecord
    belongs_to :book
    belongs_to :topic
end
