class Mailer < ActionMailer::Base
  #default from: "subscriptions@#{root_path}"

  def subscription_activation(subscription, request)
  	@subscription = subscription
  	@request = request
  	mail(to: @subscription.email,
  		from: "subscriptions@#{request.host}",
  		subject: "Subscription awaiting activation")
  end

  def new_post(post, request)
  	@post = post
  	@request = request
    @shorten_posts = true
    mail(to: Subscription.where(active: true).each.map {|s| s.email},
      from:"subscriptions@#{request.host}",
      subject: "New Post!")
  end
end
