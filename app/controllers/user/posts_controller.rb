class User::PostsController < ApplicationController
   before_action :set_q,:search, only: [:index, :search]
  
 def new
  @post = Post.new
 end
  
 def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  if @post.save
  @post.create_notification_post!(current_user)
  flash[:notice] = 'うちの子を投稿しました。'
  redirect_to user_posts_path
  else
  flash.now[:notice] = '必要事項を入力してください。'
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
  
 def search
  @results = @q.result.order(created_at: :desc).page(params[:page]).per(4)
 end
     
 def destroy
  @post = Post.find(params[:id])
  @post.destroy  
  redirect_to user_posts_path 
 end
  
  
 private
  
 def set_q # params[:q]のqには検索フォームに入力した値が入る
  @q = Post.ransack(params[:q])
 end
  
 def post_params
  params.require(:post).permit(:title, :body, :image)
 end
  
  
    
end

