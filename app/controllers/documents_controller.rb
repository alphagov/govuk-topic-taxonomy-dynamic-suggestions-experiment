class DocumentsController < ApplicationController
  def index
    @documents = Document.select(:id, :title)
  end

  def show
    @document = Document.find(params[:id])
    @similar_documents = @document.nearest_neighbors(:embedding, distance: 'cosine').first(5)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params.expect(document: [:title, :body]))
    text_to_embed = [@document.title, @document.body].join(' ')
    embedding = RubyLLM.embed(
      text_to_embed,
      provider: 'openrouter',
      model: 'qwen/qwen3-embedding-4b',
      assume_model_exists: true
    )
    @document.embedding = embedding.vectors
    @document.taxons = []
    @similar_documents = @document.nearest_neighbors(:embedding, distance: 'cosine').first(5)

    render :show
  end
end
