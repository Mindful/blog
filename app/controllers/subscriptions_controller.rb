class SubscriptionsController < ApplicationController

	include ActionView::Helpers::JavaScriptHelper
	
	def init
		email = params[:subscribe]
		@subscription = Subscription.new(email:email)
		#when we eventually save, rescue to catch exceptions

		if (email=="")
			subscribed_window j("We can't subscribe you without an email address!")
			return
		end

		unless email.match(VALID_EMAIL_REGEX)
		  subscribed_window "Unfortunately, it appears you have entered an invalid email address.", false
		  return
		end

		if duplicate? email
			return
		end

		if (@subscription.save rescue false) #Rescue catches database exception
			subscribed_window "Thanks for subscribing! A confirmation email has been sent to #{email}."
			#Confirmation email
		else
			subscribed_window "Apologies, but we were unable to subscribe you."
		end
	end

	def create #accessed through confirmation page
		#attempt to find by confirm_key, else redirect to root_path
	end

	def destroy
	end

	def resend
	end

	private
	  def activation_email(subscription)
	  end
	  
	  def subscribed_window(text, clear = true)
	  	render :js => "openSubscribedWindow('#{text}', #{clear});"
	  end

	  def duplicate?(email)
	  	subscription = Subscription.find_by(email: email)
	  	if subscription && @subscription.active
	  		subscribed_window "The address #{email} is already subscribed.", false
	  		true
	  	elsif subscription
	  		subscribed_window "The subscription for #{email} is pending. Check for an activation email."
	  		true
	  	else
	  		false
	  	end
	  end


end
