class UsersController < ApplicationController
	#before_action :authenticate_user!
	def index
		users = User.all
		render json: users, status: :ok
	end

	def show
		user = params[:id]? User.find(params[:id]) : current_user
		if user
			render json: user, status: :ok
		else
			render json: { errors: "non valid user or not loged in" }, status: :not_found
		end
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
		user = User.find(params[:id])
		user.avatar.purge_later if user.avatar.attached?

		if user.update(user_params)
			render json: user, status: :ok
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
			params.require(:user).permit(:handle, :birthday, :email, :password, :avatar)
			#note that avatar is not mandatory, and it is intended to be setted after account creation
    end
end
