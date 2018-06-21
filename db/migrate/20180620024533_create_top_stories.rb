class CreateTopStories < ActiveRecord::Migration[5.1]
  def change
    create_table :top_stories do |t|
      t.string :title
      t.string :author
      t.string :url
      t.integer :comments_num
      t.integer :score

      t.timestamps
    end
  end
end
