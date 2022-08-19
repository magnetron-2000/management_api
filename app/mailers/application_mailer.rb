class ApplicationMailer < ActionMailer::Base
  default from: ENV['default_mail_account']
  layout 'mailer'
end
