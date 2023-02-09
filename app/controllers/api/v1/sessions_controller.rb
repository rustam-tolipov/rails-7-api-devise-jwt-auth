module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        if current_user
          render json: resource, status: :ok
        else
          head :unauthorized
        end
      end

      def respond_to_on_destroy
        if current_user
          render json: {
            message: 'logged out successfully'
          }, status: :ok
        else
          head :unauthorized
        end
      end
    end
  end
end
