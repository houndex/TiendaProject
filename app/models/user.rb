class User < ActiveRecord::Base
  validates :password, presence: true
  validates :name, presence: true
  has_many :sells

  mount_uploader :avatar, AvatarUploader

  after_create :send_email

  def login
    User.where(email: self.email, password: self.password).first
  end

  #callback for sending the email
  def send_email
    # RegisterMailer.registration(self).deliver_now
    SendEmailJob.set(wait: 30.seconds).perform_later(self)
  end

end
