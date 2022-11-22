class User::HomesController < ApplicationController
 def top
 end

 def about #（イベントと防災情報を表示する）
  @events = Event.all
 end

end
