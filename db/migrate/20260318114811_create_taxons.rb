class CreateTaxons < ActiveRecord::Migration[8.1]
  def change
    create_table :taxons do |t|
      t.uuid :content_store_id, null: false
      t.string :title, null: false
      t.string :base_path, null: false
      t.string :parent_base_path
      t.timestamps
    end
  end
end
