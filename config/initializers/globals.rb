VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
DOMAIN = 'jetblog.com'
MAIL_DOMAIN = DOMAIN

DISQUS_SHORTNAME = Rails.env == 'production' ? 'TODO' : 'jetblogtest'

MAPS_DEFAULT_LAT = 34.89930
MAPS_DEFAULT_LNG = 132.07978