class AnimegifsController < ApplicationController

   

  
	def new
		@Animegif = Animegif.new
	end
	def index

	end
	def show
		@Animegif = Animegif.friendly.find(params[:id])

	end

	def create
		@Animegif = User.new
		if @Animegif.save
			redirect_to @user
		end
	end
end
