VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
DOMAIN = 'jetblog.com'
MAIL_DOMAIN = DOMAIN

DISQUS_SHORTNAME = Rails.env == 'production' ? todo : 'jetblogtest'