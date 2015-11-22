class PagesController < ApplicationController

	
	def index

		#For some reason per_page is -2 the actual number

		@animegif = Animegif.paginate(:page => params[:page], :per_page => 12).order('created_at DESC')

		##Post.page(params[:page]).order('created_at DESC')	

	end

	def random
		@animegif = Animegif.limit(12).order("RANDOM()")
	end

	def search
		@animegif = Animegif.search_by_name(params[:search])
	end

	def ratingsort

		@animegif = Animegif.paginate(:page => params[:page], :per_page => 12).order('score DESC')
	end

	def contact

	end

	def about

	end

	def list

	end
end
