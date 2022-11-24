class AdminMailer < ApplicationMailer
  
  def send_mail(user, message)
   @user = user
   @message = message
   mail(to: user.email, subject: '会費のお知らせ')
  end
  
end
