class AddPublicToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :public, :boolean
  end
end
