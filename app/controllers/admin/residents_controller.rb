class Admin::ResidentsController < ApplicationController
  def index
    @users =  User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
   
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_resident_path(@user)
   end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :fee_status)
  end

end
