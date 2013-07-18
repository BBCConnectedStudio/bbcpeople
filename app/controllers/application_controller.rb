class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  #unless Rails.application.config.consider_all_requests_local
    #rescue_from Exception, :with => :render_error
    #rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    #rescue_from ActionController::RoutingError, :with => :render_not_found
    #rescue_from ActionController::UnknownController, :with => :render_not_found
  #end

  private

  def render_not_found(exception)
    render "#{Rails.root.to_s}/public/404", :status => 404
  end

  def render_error(exception)
    render "#{Rails.root.to_s}/public/500", :status => 404
  end
end
