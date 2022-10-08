class TreeDataService
  attr_accessor :tree

  def initialize
    @tree = []
  end

  def generate
    Document.where(ancestry: nil).each do |document|
      tree << { name: document.name, id: document.id, children: document_children(document) }
    end

    tree
  end

  private

  def document_children(document)
    child_documents = Document.where(ancestry: document.id)
    return [] if child_documents.empty?

    child_documents.map do |child_document|
      { name: child_document.name, id: child_document.id, children: document_children(child_document) }
    end
  end
end