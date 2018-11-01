class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :store_user_location!, if: :storable_location?  # For redirects back to referring page
  
  def admin_auth    
    unless admin?  
      redirect_to request.env["HTTP_REFERER"] || '/', :alert => "You must be an admin to perform that action." 
    end
  end
  
  def admin?
    current_user.try(:admin?)
  end  

  private

    # Don't store if: not GET, handled by Devise controller, request is Ajax
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

end
