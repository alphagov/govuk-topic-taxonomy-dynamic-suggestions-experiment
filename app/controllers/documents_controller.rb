class DocumentsController < ApplicationController
  def index
    @documents = Document.published.select(:id, :title)
  end

  def show
    @document = Document.find(params[:id])
    @similar_documents = @document.nearest_neighbors(:embedding, distance: 'cosine').select(&:published?).first(5)
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
    @document.content_store_id = SecureRandom.uuid
    @document.draft = true
    @document.embedding = embedding.vectors

    if @document.save
      redirect_to document_path(@document)
    else
      flash[:alert] = @document.errors.full_messages.to_sentence
      render :new
    end
  end
end
