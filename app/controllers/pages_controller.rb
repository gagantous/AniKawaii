class PagesController < ApplicationController


	
	def index
		#For some reason per_page is -2 the actual number
		@animegif = Animegif.paginate(page: params[:page], per_page: 12)	

	end

	def contact

	end

	def about

	end

	def list

	end
end
