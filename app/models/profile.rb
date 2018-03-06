class Profile < ApplicationRecord
    enum role: [:user, :profile_user]
    belongs_to :user
end