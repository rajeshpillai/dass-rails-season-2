class PublicController < ApplicationController
  def index
    # @posts = Post.all
    @posts = Post.includes(:tags, :category).order(created_at: :desc)
    @categories = Category.all
  end

  # Search input for tag
  def tags 
    tag = params[:tag]
    @posts =  Tag.find_by(:name => tag).posts     #Tag.where(name: tag)
  end
end
