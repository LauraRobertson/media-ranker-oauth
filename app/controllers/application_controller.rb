class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user, except: [:root, :create]
  before_action :root_find_user, only: [:root]

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])

    else
      flash[:status] = :success
      flash[:result_text] = "You need to be logged in to do that"
      redirect_to root_path
    end
  end

  def root_find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
