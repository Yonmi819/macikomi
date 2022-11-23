class Admin::ResidentsController < ApplicationController
  
 def index
  @users =  User.page(params[:page]).per(6)
 end

 def show
  @user = User.find(params[:id])
 end

 def edit
  @user = User.find(params[:id])
 end
  
 def send_mail
  @user = User.find(params[:id])
  @message = params[:message]
  AdminMailer.send_mail(@user, @message).deliver_now
  redirect_to admin_residents_path
 end
  
 def form
  @user = User.find(params[:id])
 end
  
 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
  flash[:notice] = "ユーザー情報を変更しました"
  redirect_to admin_resident_path(@user)
  else
  flash.now[:notice] = "必要事項を入力してください"
  render :edit
  end
 end
  
 private
  
 def user_params
  params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :fee_status)
 end

end
