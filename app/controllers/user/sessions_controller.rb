# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
   
   # 退会しているかを判断するメソッド
# def user_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
 # @user = User.find_by(email: params[:user][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
  #return if !@user
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
  #if @user.valid_password?(params[:user][:password])
    ## 【処理内容3】
  #end
  #end
  protected

  def reject_user
    @user = User.find(params[:id])
      if @user
        if @user.valid_password?(params[:email][:password]) &&  (@user.active_for_authentication? == true)
         flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。" 
         redirect_to new_user_registration_path
        else
         flash[:notice] = "項目を入力してください"
        end
      end
  end

end
