class Document < ApplicationRecord
  has_neighbors :embedding

  attr_accessor :body

  validates :title, presence: true

  def govuk_url
    "https://www.gov.uk#{base_path}"
  end
end
