class Mailer < ActionMailer::Base
  default from: "subscriptions@#{MAIL_DOMAIN}"

  def subscription_activation(subscription, request)
  	@subscription = subscription
  	@request = request
    attachments.inline['shimane_flag.gif'] = File.read("#{Rails.root}/app/assets/images/shimane_flag.gif")
  	mail(to: @subscription.email,
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
        subject: "New post: \"@post.title\"",
        css: "email")#.deliver #Supposedly not necessary with delayed job
    end
  end
end
