class Subscription < ActiveRecord::Base

  validates :email, presence:   true,
                format:     { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }


  before_save { self.email = email.downcase }
end
