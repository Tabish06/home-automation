class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: ['omniauth']

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user

    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination' # Not quite right!

      render 'new'
    end
  end

  def omniauth
    # byebug
    render status: 200,json: {status: 'OK'}
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
