class ChangeDefaultForTaxonsOnDocuments < ActiveRecord::Migration[8.1]
  def change
    change_column_default :documents, :taxons, from: nil, to: []
  end
end
