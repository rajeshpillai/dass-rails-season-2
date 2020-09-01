class PublicController < ApplicationController
  def index
    # @posts = @q.result().page(params[:page]).per(10)
    @posts = Post.includes(:tags, :category).order(created_at: :desc).page(params[:page]).per(10)
    @categories = Category.all
    @tags = Tag.all
  end

  def read
    # @post = Post.find_by_slug(params[:slug])
    @post = Post.friendly.find(params[:id])

  end

  # Search input for tag
  def tags 
    tag = params[:tag]
    @posts =  Tag.find_by(:name => tag).posts     #Tag.where(name: tag)
  end

  def category
    category = params[:category]
    @posts =  Category.where('lower(name) = ?', category.downcase).first.posts
  end
end
