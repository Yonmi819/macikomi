class User::ChecksController < ApplicationController
  
  def create 
    @post = Post.find(params[:post_id])
    check = current_user.checks.new(post_id: @post.id)
    check.save
  end
  
  def destroy 
    @post = Post.find(params[:post_id])
    check = current_user.checks.find_by(post_id: @post.id)
    check.destroy
  end
end