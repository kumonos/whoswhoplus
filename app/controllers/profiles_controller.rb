class ProfilesController < ApplicationController
	def index
		@profiles=Profile.order("id")

	end
	def search
	end
	def show
	end
	def new
	end
	def edit
	end
	def create
	end
	def update
	end
	def destory
	end
end
