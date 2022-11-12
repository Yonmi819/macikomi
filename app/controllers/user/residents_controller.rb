class User::ResidentsController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:notice] ="ユーザー情報を変更しました"
       redirect_to user_my_page_path
    end
  end 
  
  def unsubscribe
     @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(delete_flag: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
 
 private
 
 def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :fee_status)
 end


end