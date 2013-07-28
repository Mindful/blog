class SubscriptionsController < ApplicationController
	
	def init
		email = params[:subscribe]
		@subscription = Subscription.new(email:email)
		#when we eventually save, rescue to catch exceptions
		if (@subscription.valid?) 
			#render :js => "alert('you were successfuly subscribed #{email}');"
			subscribed_window "Thank you for subscribing! A confirmation email has been sent to #{email}."
			#Use JS to make something pretty and clear out the subscribe box of text
			#Also, confirmation email
		else
			#detect error type. if empty, do nothing. if invalid, say invalid. if duplicate or exception, say it
			subscribed_window "could not subscribe you. already subscribed?"
		end
	end

	def create #accessed through confirmation page
	end

	def destroy
	end

	private
	  def subscribed_window(text)
	  	render :js => "openSubscribedWindow('#{text}');"
	  end

end
