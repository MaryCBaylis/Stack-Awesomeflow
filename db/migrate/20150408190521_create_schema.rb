class CreateSchema < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_index :questions, :user_id

    create_table :answers do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      t.boolean :is_best

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :question_id

    create_table :responses do |t|
      t.text :body
      t.integer :user_id
      t.string :post_type
      t.integer :post_id

      t.timestamps
    end
    add_index :responses, :user_id
    add_index :responses, :post_id

    create_table :votes do |t|
      t.integer :value
      t.integer :user_id
      t.string :votable_type
      t.integer :votable_id

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :votable_id
  end
end
