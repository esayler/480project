class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      auth = request.env["omniauth.auth"]
      @user = User.where(provider: auth.provider, uid: auth.uid).first
      if !(@user==nil)
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        session[:user_id]=@user.id
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_path
      end
  end
end