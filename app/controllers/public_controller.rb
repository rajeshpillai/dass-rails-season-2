class PublicController < ApplicationController
  def index
    # @posts = @q.result().page(params[:page]).per(10)
    @posts = Post.includes(:tags, :category).order(created_at: :desc).page(params[:page]).per(10)
    @categories = Category.all

    # Tag.joins(:posts).group("tags.name").select("tags.id, tags.name, count(posts.id) as
    #  total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}
    
    # Query
    # SELECT tags.id, tags.name, count(posts.id) as total_posts FROM "tags" 
    #    INNER JOIN "taggings" ON "taggings"."tag_id" = "tags"."id" 
    #    INNER JOIN "posts" ON "posts"."id" = "taggings"."post_id" GROUP BY tags.name

    @tags = Tag.joins(:posts).group("tags.name").select("tags.id, tags.name, count(posts.id) as
    total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}
    
    p "TAGS: ", @tags
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
