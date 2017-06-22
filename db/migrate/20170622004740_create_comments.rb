class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :suggestion, foreign_key: true
      t.text :comment_text

      t.timestamps
    end
  end
end
