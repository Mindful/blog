class Mailer < ActionMailer::Base
  #default from: "subscriptions@#{root_path}"

  def subscription_activation(subscription, request)
  	@subscription = subscription
  	@request = request
    attachments.inline['shimane_flag.gif'] = File.read("#{Rails.root}/app/assets/images/shimane_flag.gif")
  	mail(to: @subscription.email,
  		from: "subscriptions@#{request.host}",
  		subject: "Subscription awaiting activation",
      css: "email").deliver
  end

  def new_post(post, request)
    #This doesn't really work, because we need to tailor the email to each person (at the very least, with an unsubscribe link)
  	@post = post
  	@request = request
    attachments.inline['shimane_flag.gif'] = File.read("#{Rails.root}/app/assets/images/shimane_flag.gif")
    Subscription.where(active: true).each do |subscription|
      @subscription = subscription
      mail(to: subscription.email,
        from:"subscriptions@#{request.host}",
        subject: "New post: \"@post.title\"",
        css: "email").deliver
    end
  end
end
