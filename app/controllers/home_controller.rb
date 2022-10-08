# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tree_documents = TreeDataService.new.generate
  end
end
