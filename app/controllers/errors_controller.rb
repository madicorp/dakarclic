class ErrorsController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def internal_server_error
  end
end
