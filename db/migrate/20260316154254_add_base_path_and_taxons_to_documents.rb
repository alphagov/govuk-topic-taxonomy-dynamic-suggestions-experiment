class AddBasePathAndTaxonsToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :base_path, :string
    add_column :documents, :taxons, :jsonb
  end
end
