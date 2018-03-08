class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :genre
      t.integer :year
      t.string :plot
      t.belongs_to :user, index: true
      
      t.timestamps
    end
  end
end
