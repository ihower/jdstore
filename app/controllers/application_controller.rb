class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "You are not admin."
    end
  end

end
