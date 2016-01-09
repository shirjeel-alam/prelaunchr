# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  email         :string(255)
#  referral_code :string(255)
#  referrer_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
    
    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    after_create :send_welcome_email

    REFERRAL_STEPS = [
      {
        'count' => 5,
        "html" => "1x Free Bag",
        "class" => "two",
        "image" =>  ActionController::Base.helpers.asset_path("refer/HUB-1XFree.png")
      },
      {
        'count' => 10,
        "html" => "2x Free Bags + Definitive Guide To Healthy Living E-Book",
        "class" => "three",
        "image" => ActionController::Base.helpers.asset_path("refer/HUB-2xFree+e-book.png")
      },
      {
        'count' => 25,
        "html" => "3x Free bags + How You Bean Glass Drink Bottle",
        "class" => "four",
        "image" => ActionController::Base.helpers.asset_path("refer/HUB-3XFree+Bottle.png")
      },
      {
        'count' => 50,
        "html" => "Free 1 year supply + special edition How You Bean Coffee Plunger",
        "class" => "five",
        "image" => ActionController::Base.helpers.asset_path("refer/HUB-50-Referral.png")
      }
    ]

    def num_referred
      referrals.count
    end

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        # UserMailer.delay.signup_email(self)
        UserMailer.signup_email(self).deliver
    end
end
