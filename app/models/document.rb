class Document < ApplicationRecord
  has_neighbors :embedding

  attr_accessor :body

  def govuk_url
    "https://www.gov.uk#{base_path}"
  end
end
