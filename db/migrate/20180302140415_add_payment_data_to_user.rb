class AddPaymentDataToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subscribed_at, :datetime
    add_column :users, :expired_at, :datetime
  end
end
