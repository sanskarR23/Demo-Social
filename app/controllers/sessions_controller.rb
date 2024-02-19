# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        user.generate_otp
        send_otp_email(user)
        redirect_to otp_path
      else
        flash[:error] = "Invalid email/password combination"
        render 'new'
      end
    end
  
    def verify_otp
      user = User.find_by(email: params[:email])
      if user && user.otp_valid?(params[:otp])
        log_in user
        redirect_to user
      else
        flash[:error] = "Invalid OTP"
        render 'otp'
      end
    end
  
    private
  
    def send_otp_email(user)
      # Use mail gem to send OTP via email
      # Example:
       mail = Mail.new do
         from    'sanskarr2308@gmail.com'
        to      user.email
        subject 'One Time Password'
        body    "Your OTP: #{user.otp_secret}"
      end
      mail.deliver
    end
  end
  