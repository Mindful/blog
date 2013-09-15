class Mailer < ActionMailer::Base
  default from: "subscriptions@#{MAIL_DOMAIN}"


  def subscription_activation(subscription, host, port)
  	@subscription = subscription
  	@host = host
    @port = port
    attachments.inline['shimane_flag.gif'] = File.read("#{Rails.root}/app/assets/images/shimane_flag.gif")
  	mail(to: @subscription.email,
  		subject: "Subscription awaiting activation",
      css: "email")
  end

  def new_post(post, subscription, host, port)
    #This doesn't really work, because we need to tailor the email to each person (at the very least, with an unsubscribe link)
  	@post = post
    @host = host
    @port = port
    @subscription = subscription
    attachments.inline['shimane_flag.gif'] = File.read("#{Rails.root}/app/assets/images/shimane_flag.gif")
    mail(to: subscription.email,
      subject: "New post: \"#{@post.title}\"",
      css: "email")
  end
end
