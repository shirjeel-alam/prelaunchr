class UsersController < ApplicationController
  before_filter :skip_first_page, :only => :new
  skip_before_filter  :verify_authenticity_token, only: :webhook

  def new
    # @bodyId = 'home'
    # @is_mobile = mobile_device?

    # @user = User.new

    # respond_to do |format|
    #   format.html # new.html.erb
    # end

    redirect_to 'http://prelaunch.howyoubean.org/green-coffee-bean/'
  end

  def create
    # Get user to see if they have already signed up
    @user = User.find_by_email(params[:user][:email]);
        
    # If user doesnt exist, make them, and attach referrer
    if @user.nil?
      store_ip(request.env['HTTP_X_FORWARDED_FOR'])

      @user = User.new(:email => params[:user][:email])
      @referred_by = User.find_by_referral_code(cookies[:h_ref])
      @user.referrer = @referred_by if @referred_by.present?
      @user.save

      # puts '------------'
      # puts @referred_by.email if @referred_by
      # puts params[:user][:email].inspect
      # puts request.env['HTTP_X_FORWARDED_FOR'].inspect
      # puts '------------'
    end

    # Send them over refer action
    respond_to do |format|
      if @user.present?
        cookies[:h_email] = { :value => @user.email }
        format.html { redirect_to '/refer-a-friend' }
      else
        format.html { redirect_to root_path, :alert => "Something went wrong!" }
      end
    end
  end

  def refer
    email = cookies[:h_email]

    @bodyId = 'refer'
    @is_mobile = mobile_device?

    @user = User.find_by_email(email)

    respond_to do |format|
      if @user.present?
        format.html #refer.html.erb
      else
        format.html { redirect_to root_path, :alert => "Something went wrong!" }
      end
    end
  end

  def policy
        
  end  

  def redirect
    redirect_to root_path, status: 404
  end

  def webhook
    email = params[:your_best_email_address]
    ip_address = request.env['HTTP_X_FORWARDED_FOR']

    @user = User.find_by_email(email)
    if @user.blank?
      store_ip(ip_address)
      @user = User.new(email: email)
      @referred_by = User.find_by_referral_code(cookies[:h_ref])
      @user.referrer = @referred_by if @referred_by.present?
      @user.save
    end

    # Send them over refer action
    respond_to do |format|
      if @user.present?
        cookies[:h_email] = { value: @user.email }
        format.html { redirect_to '/refer-a-friend' }
      else
        format.html { redirect_to root_path, alert: "Something went wrong!" }
      end
    end
  end

  private 

    def skip_first_page
      if !Rails.application.config.ended
        email = cookies[:h_email]
        if email and !User.find_by_email(email).nil?
          redirect_to '/refer-a-friend'
        else
          cookies.delete :h_email
        end
      end
    end

    def store_ip(ip)
      cur_ip = IpAddress.find_by_address(ip) 
      cur_ip = IpAddress.create(address: ip, count: 0) if !cur_ip
      # if cur_ip.count > 2
      #   return redirect_to root_path
      # else
      #   cur_ip.update_attribute(:count, cur_ip.count + 1)
      # end
      cur_ip.update_attribute(:count, cur_ip.count + 1)
    end

end
