class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :teams,
    through: :teammates
  has_many :boxes,
    through: :teams
  has_many :meats

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_create :generate_api_key

  def generate_api_key
    self.api_key = Digest::MD5.hexdigest("#{email}#{created_at.to_s}")
  end
end
