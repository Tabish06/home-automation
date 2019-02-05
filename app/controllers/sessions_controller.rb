class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: ['omniauth']
  @@client
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

  def authorize
    if listing = Listing.find_by_id(params[:listing_id])
      @@client = OAuth2::Client.new(listing.client_id, listing.client_secret, options)
      session[:listing_id] = listing.id
      if Rails.env == 'development'
        redirect_uri = 'https://35e48889.ngrok.io/oauth/callback'
      else
        redirect_uri = request.host + '/oauth/callback'
      end
      url = @@client.auth_code.authorize_url(redirect_uri: redirect_uri, scope: 'app')
      redirect_to url
    else 
      flash[:error] = "Listing cannot be found"
    end
  end

  def omniauth
    # byebug

    if Rails.env == 'development'
      redirect_uri = 'https://35e48889.ngrok.io/oauth/callback'
    else
      redirect_uri = request.host + '/oauth/callback'
    end
    code = params['code']
    response = @@client.auth_code.get_token(code, redirect_uri: redirect_uri, scope: 'app')
    print(response.token)
    if listing = Listing.where(id: session[:listing_id]).first
      token = response.token
      listing.update_column(:token,token)
    end
    flash[:success]
    redirect_to root_url

  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
    def options
      options = {
        site: 'https://graph.api.smartthings.com',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }

    end
end
