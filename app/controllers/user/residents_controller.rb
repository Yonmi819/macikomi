class User::ResidentsController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
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
   else
    flash.now[:notice] ="必要事項を入力してください"
    render :edit
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
 
  def ensure_guest_user
    @user = User.find(params[:id])
   if @user.last_name == "ゲスト"
      redirect_to  user_resident_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
   end
  end  

end