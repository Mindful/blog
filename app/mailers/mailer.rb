class Mailer < ActionMailer::Base
  #default from: "subscriptions@#{root_path}"

  def subscription_activation(subscription, request)
  	@subscription = subscription
  	@request = request
  	mail(to: @subscription.email,
  		from: "subscriptions@#{root_path}",
  		subject: "Subscription awaiting activation")
  end
end
