class UsersController < ApplicationController
    #before_action :authenticate_user!
    def index
        users = User.all
        render json: users, status: :ok
    end

    def show
        user = User.find(params[:id])
        render json: user, status: :ok
    end

    def create
        user = User.create(user_params)
        if user.valid?
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end

    def update
        if current_user.update_attributes(user_params)
            render :show
        else
            render json: {errors: current_user.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        if user.destroyed?
            render json: user, status: :ok
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end
    
    private

        def user_params
            params.require(:user).permit(:handle, :birthday, :email, :password)
        end
        
end
