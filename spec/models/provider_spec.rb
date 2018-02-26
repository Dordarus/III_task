require 'rails_helper'

RSpec.describe Provider, type: :model do
  it{should belong_to(:user)}
end
