module Api
  module V1
    class UsersController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      before_action :authenticate_user!, only: [:me, :show, :update, :follow, :unfollow, :following, :followers]
      before_action :set_user, only: [:update, :destroy, :follow, :unfollow, :followers, :following, :user_posts]
      before_action :set_user_by_username, only: [:show_by_username]

      def me
        render json: current_user, serializer: UserSerializer, status: :ok
      end

      def show
        render json: @user, serializer: UserSerializer, status: :ok
      end

      def show_by_username
        if @user
          render json: @user, serializer: UserSerializer, status: :ok
        else
          render json: {
            message: "User not found"
          }, status: :not_found
        end
      end

      # Get /users/1/posts
      def user_posts
        @posts = @user.posts.all.order(created_at: :desc)
        render json: @posts, each_serializer: PostSerializer, status: :ok
      end

      def search
        @users = User.search(params[:username])
        render json: @users, each_serializer: UserSerializer, status: :ok
      end

      def update
        if @user.update(user_params)
          render json: @user, serializer: UserSerializer, status: :ok
        else
          render_error(@user, :unprocessable_entity)
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_user_by_username
        @user = User.find_by(username: params[:username])
      end

      def user_params
        params.permit(:id, :first_name, :last_name, :email, :avatar, :username, :bio)
      end

      def not_found
        render json: { error: 'Not Found' }, status: :not_found
      end

      # Render error message
      def render_error(object, status)
        render json: {
          errors: object.errors.full_messages
        }, status: status
      end
    end
  end
end
