class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def process_post

    PostPublishingJob.perform_later

    render plain: "Delayed job"
  end

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.includes(:category).page(params[:page]).per(10)
    @q = Post.ransack(params[:q])
    @posts = @q.result().page(params[:page]).per(10)

    # @posts_published = Post.published
    # @posts_unpublished = Post.unpublished

    # @top_5 = Post.limit_5

    # @latest_posts = Post.order_by_latest_first

    # @all_combinded = Post.published.order_by_latest_first.limit_5

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # KEPT FOR REFERENCE 

    #render json: @post 
    # respond_to do |format|
    #     format.html 
    #     # format.json{ render json:@post}
    #     format.json { render json: @post.as_json(
    #       only: [:id, :name, :body],
    #       methods: :post_body,
    #       include: [:category, {tags: {only:[:name]}}])
    #     }
    # end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    # alltags = all_tags(params[:post][:all_tags])

    # loops and explicitly creates

    @post = Post.new(post_params)
    # @post.tags = alltags


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #  def all_tags(names)
  #     if names.blank? 
  #        return 
  #     end
  #     # ruby, rails
  #     tags = names.split(",").map do |name| 
  #        unless name.blank?  
  #           Tag.where(name: name.strip).first_or_create!
  #        end
  #     end
  #  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :published, :category_id, :all_tags, tag_ids:[])
    end
end
