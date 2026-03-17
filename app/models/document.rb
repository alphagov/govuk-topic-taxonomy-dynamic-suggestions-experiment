class Document < ApplicationRecord
  has_neighbors :embedding

  attr_accessor :body

  validates :title, presence: true

  scope :published, -> { where(draft: false) }

  def published?
    !draft?
  end

  def govuk_url
    return if draft?

    "https://www.gov.uk#{base_path}"
  end
end
