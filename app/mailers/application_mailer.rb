class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@test.com'
  layout 'mailer'
end
