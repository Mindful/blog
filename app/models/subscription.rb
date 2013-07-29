class Subscription < ActiveRecord::Base

  validates :email, presence:   true,
                format:     { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }


  before_save { self.email = email.downcase }
  after_create :create_confirm_token

  private
    def create_confirm_token
    	self.confirm_token = (SecureRandom.urlsafe_base64 + self.id.to_s)
    	save
    end
end
