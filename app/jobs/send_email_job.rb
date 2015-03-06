class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
  	RegisterMailer.register(user).deliver_later
    # Do something later
  end
end
