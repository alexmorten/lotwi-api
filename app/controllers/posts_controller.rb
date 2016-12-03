class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

# GET /posts ?limit & lat & lng & dist
  def index
    limit = params[:limit] || 20
    lat = params[:lat]
    lng = params[:lng]
    dist = params[:dist]

    if lat && lng && dist
      @posts = Post.joins(:location)
                   .within(dist, :origin => [lat,lng])
                   .order(created_at: :desc)
                   .limit(limit)
    elsif lat && lng
      @posts = Post.by_distance(:origin => [lat,lng])
                   .limit(limit)
    else
      @posts = Post.order(created_at: :desc)
                   .limit(limit)
    end


    render json: @posts, lat: lat, lng: lng
  end

  # GET /posts/1
  def show
    render json: @post, lat: params[:lat], lng: params[:lng]
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
