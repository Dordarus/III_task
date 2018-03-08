class CreateBooksTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :books_topics, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :topic, index: true
    end
  end
end
