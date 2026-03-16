class DocumentsController < ApplicationController
  def index
    @documents = Document.select(:title)
  end
end
