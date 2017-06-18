class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :person, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
