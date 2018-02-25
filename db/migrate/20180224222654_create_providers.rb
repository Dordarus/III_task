class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
