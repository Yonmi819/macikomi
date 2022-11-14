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
  
  def send_mail
    @user = User.find(params[:id])
    @message = params[:message]
    AdminMailer.send_mail(@user, @message).deliver_now
    redirect_to admin_residents_path
  end
  
  def form
    @user = User.find(params[:id])
  end
  
  
  #def send
  #  byebug
    #AdminMailer.(user: @user.id).send_mail.deliver_now
  #end

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
