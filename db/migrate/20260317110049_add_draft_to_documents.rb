class AddDraftToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :draft, :boolean, default: false

    update 'UPDATE documents SET draft = false'

    change_column_null :documents, :draft, false
  end
end
