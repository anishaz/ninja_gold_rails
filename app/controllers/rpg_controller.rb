class RpgController < ApplicationController
  Time.zone = "Pacific Time (US & Canada)"
  def index
    unless session[:gold]
			session[:gold] = 0
		end
		unless session[:activities]
			session[:activities] = []
		end
		@gold = session[:gold]
		@activities = session[:activities]
  end

  def process_money
    if params[:building] == "farm"
      gold = rand(10..20)
      message = "Earned #{gold} gold coins from the farm! #{Time.zone.now.strftime("%b. %d, %Y %I:%M %p")}"
    elsif params[:building] == "cave"
      gold = rand(5..10)
      message = "Earned #{gold} gold coins from the cave! #{Time.zone.now.strftime("%b. %d, %Y %I:%M %p")}"
    elsif params[:building] == "house"
      gold = rand(2..5)
      message = "Earned #{gold} gold coins from the house! #{Time.zone.now.strftime("%b. %d, %Y %I:%M %p")}"
    elsif params[:building] == "casino"
      gold = rand(-50..50)
      if gold < 0
        message =  "Lost #{gold} gold coins from the casino! Ouch! #{Time.zone.now.strftime("%b. %d, %Y %I:%M %p")}"
      elsif gold > 0
        message = "Earned #{gold} gold coins from the casino! #{Time.zone.now.strftime("%b. %d, %Y %I:%M %p")}"
      end
    end
    session[:gold] += gold
    session[:activities] << message
    redirect_to :root
  end

  def reset
    reset_session
    redirect_to :root
  end
end
