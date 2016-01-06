class UserMailer < ActionMailer::Base
  helper :users

  default from: "hello@howyoubean.org"

  def signup_email(user)
    @user = user
    mail(:to => user.email, :subject => "The Coffee Game Is Changing...")
  end
end
