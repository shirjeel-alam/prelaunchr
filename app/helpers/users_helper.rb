module UsersHelper
  def referral_url(user)
    "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/?ref=#{user.referral_code}"
  end
end
