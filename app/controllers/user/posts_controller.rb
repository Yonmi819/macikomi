class User::PostsController < ApplicationController
  def new
    @post  = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to user_posts_path
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
    @post = Post.find(params[:id])  # データ（レコード）を1件取得
    @post.destroy  # データ（レコード）を削除
    redirect_to user_posts_path  # 投稿一覧画面へリダイレクト  
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
    
end
