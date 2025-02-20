module Api
  module V1
    class ApplicationController < ActionController::API
      include Authenticatable
    end
  end
end
