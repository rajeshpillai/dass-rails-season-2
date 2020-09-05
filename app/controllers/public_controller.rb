class PublicController < ApplicationController
  before_action :authenticate_user!, only: [:comments]
  def index
    # @posts = @q.result().page(params[:page]).per(10)
    @posts = Post.includes(:tags, :category).order(created_at: :desc).page(params[:page]).per(10)
    
    # Tag.joins(:posts).group("tags.name").select("tags.id, tags.name, count(posts.id) as
    #  total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}
    
    # Query
    # SELECT tags.id, tags.name, count(posts.id) as total_posts FROM "tags" 
    #    INNER JOIN "taggings" ON "taggings"."tag_id" = "tags"."id" 
    #    INNER JOIN "posts" ON "posts"."id" = "taggings"."post_id" GROUP BY tags.name
    
    # @categories = Category.all
    # @tags = Tag.joins(:posts).group("tags.name").select("tags.id, tags.name, count(posts.id) as
    # total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}
   
    sidebar

    p "TAGS: ", @tags
  end


  # Post comments
  def comments
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save 

    respond_to do |format|
        format.html { redirect_to post_read_path(@post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js { render }
    end

    # redirect_to post_read_path(@post)
  end

  def read
    sidebar
    # @post = Post.find_by_slug(params[:slug])
    @post = Post.friendly.find(params[:id])

  end

  # Search input for tag
  def tags 
    sidebar
    @tags = Tag.joins(:posts).group("tags.name").select("tags.id, tags.name, count(posts.id) as
    total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}


    tag = params[:tag]
    @posts =  Tag.find_by(:name => tag).posts     #Tag.where(name: tag)
  end

  def category
    sidebar

    category = params[:category]
    @posts =  Category.where('lower(name) = ?', category.downcase).first.posts
  end

  private 
  def comment_params
    params.require(:comment).permit(:post_id, 
       :body)
  end

  def sidebar 
    @categories = Category.all
    @tags = Tag.joins(:posts)
        .group("tags.name")
        .select("tags.id, tags.name, count(posts.id) as total_posts").map { |t| {name: t.name, total_posts: t.total_posts}}
  end

end
