class ApplicationMailer < ActionMailer::Base
  default from: I18n.t("users.new.email_default")
  layout I18n.t("users.new.mailer")
end
