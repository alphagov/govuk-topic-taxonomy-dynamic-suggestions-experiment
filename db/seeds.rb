# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

CSV.foreach(Rails.root.join('db/seeds/topic_taxonomy.csv'), headers: true) do |row|
  content_store_id = row['id']
  title = row['title']
  base_path = row['base_path']
  parent_base_path = row['parent_base_path']

  taxon = Taxon.find_by(content_store_id:)
  if taxon
    taxon.update!(title:, base_path:, parent_base_path:)
  else
    Taxon.create!(content_store_id:, title:, base_path:, parent_base_path:)
  end
end

embeddings = Dir[Rails.root.join('db/seeds/embeddings/*.json')]
total = embeddings.length
embeddings.each.with_index do |path, index|
  puts "#{index} / #{total}" if index % 100 == 0

  content_store_id = File.basename(path, '.json')

  clean_path = Rails.root.join("db/seeds/clean/#{content_store_id}.json")
  clean_data = JSON.load_file(clean_path)
  base_path = clean_data['base_path']
  taxons = clean_data['taxons']

  data = JSON.load_file(path)
  title = data['title']
  embedding = data['vector']

  document = Document.find_by(content_store_id:)
  if document
    document.update!(title:, embedding:, base_path:, taxons:)
  else
    Document.create!(content_store_id:, title:, embedding:, base_path:, taxons:)
  end
end
