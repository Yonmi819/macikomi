class User::HomesController < ApplicationController
  def top
  end

  def about #（イベントページを表示する）
   @events = Event.all
  end

  def section #（災害情報を表示する)
  end
end
