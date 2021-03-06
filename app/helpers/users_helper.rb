module UsersHelper
  def referral_url(user)
    if Rails.env.production?
      "http://prelaunch.howyoubean.org/green-coffee-bean/?ref=#{user.referral_code}"
    else
      "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/?ref=#{user.referral_code}"
    end
  end

  def asset_url(asset)
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end
end
