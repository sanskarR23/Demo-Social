class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  # GET /posts or /posts.json
  def index
    @posts = Post.all
    user_id = params[:user_id]
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
     @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    @post.liked_users << current_user
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "Like.Feed.#{@post.id}",
          partial: 'posts/like_button',
          locals: { post: @post }
        )
      end
    end
  end
  
  def unlike
    @post.liked_users.delete(current_user)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "Like.Feed.#{params[:post_id]}",
          partial: 'posts/like_button',
          locals: { post: @post }
        )
      end
    end
  end
  
private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      puts "sdfgh"
      @post = Post.find(params[:id])
    end
    

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :user_id, :post_type)
    end
  end   
