class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :current_provider
      t.datetime :subscribed_at
      t.datetime :expired_at
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
