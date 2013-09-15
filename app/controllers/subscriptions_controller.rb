class SubscriptionsController < ApplicationController

	include ActionView::Helpers::JavaScriptHelper
	
	def init
		email = params[:subscribe]
		@subscription = Subscription.new(email:email)

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
			subscribed_window "Thanks for subscribing! An activation email has been sent to #{email}." #not working
			@subscription.activation_email(request)
		else
			subscribed_window "Apologies, but we were unable to subscribe you."
		end
	end

	def activate #accessed through confirmation page
		@subscription = Subscription.find_by(confirm_token: params[:confirm_token])
		unless @subscription
			redirect_to root_path 
			return
		end
		@subscription.active = true
		@subscription.save
		#render activate, which redirects to root after 10 seconds
	end

	def destroy
		@subscription = Subscription.find_by(confirm_token: params[:confirm_token])
		@subscription.destroy if @subscription
		#render destroy, which redirects to root after 10 seconds (if there was a successful destruction; I.E. if we found a subscription)
	end

	def resend
		email = params[:email]
		@subscription = Subscription.find_by(email: email)
		activation_email(@subscription, request) if @subscription
		render :js => "$('#resend').prop('disabled', true);"
	end

	private

	  def subscribed_window(text, clear = true, resend = false)
	  	@resend = resend
	  	render :js => "openSubscribedWindow('#{j(render_to_string('subscribed', :layout => nil))}', '#{text}', #{clear});"
	  end

	  def duplicate?(email)
	  	subscription = Subscription.find_by(email: email)
	  	if subscription && @subscription.active
	  		subscribed_window "The address #{email} is already subscribed.", false
	  		true
	  	elsif subscription
	  		subscribed_window "The subscription for #{email} is pending. Check for an activation email.", false, true
	  		true
	  	else
	  		false
	  	end
	  end


end
