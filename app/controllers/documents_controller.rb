class DocumentsController < ApplicationController
  def index
    @documents = Document.select(:id, :title)
  end

  def show
    @document = Document.find(params[:id])
  end
end
