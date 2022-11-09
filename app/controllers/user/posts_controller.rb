class User::PostsController < ApplicationController
  def new
    @post  = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.create_notification_post!(current_user)
      flash[:success] = 'お知らせを投稿しました。'
    redirect_to user_posts_path
    else
    flash.now[:danger] = 'お知らせの投稿に失敗しました。'
    render :new
  end
  end

  def index #新着順
     @posts = Post.order(created_at: :desc).page(params[:page]).per(4)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    
  end

  def edit
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy  
    redirect_to user_posts_path 
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
    
end

