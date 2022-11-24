class User::HomesController < ApplicationController
  def top
  end

  def about
   @events = Event.all
  end

end
