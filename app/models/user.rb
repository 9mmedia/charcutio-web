class User < ActiveRecord::Base

  # We will specify validation because in 4.0 password_confirmation is required but 
  # a change in 4.1 will support omitting password_confirmation if it attr doesn't exist
  # https://github.com/rails/rails/pull/11107/files
  has_secure_password validations: false

  validates :name, 
    presence: true
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false }
  validates :password,
    presence: true,
    on: :create

  before_create { raise "Password digest missing on new record" if password_digest.blank? }
  before_create :generate_auth_token

  protected

    def generate_auth_token
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end

end
