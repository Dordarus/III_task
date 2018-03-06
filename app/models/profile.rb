class Profile < ApplicationRecord
    enum role: [:author, :reader]
    belongs_to :user
end