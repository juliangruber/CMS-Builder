class Structure::Page
  include MongoMapper::Document
  after_save :write_routes, :write_controller_file
  before_destroy :delete_controller_file
  after_destroy :write_routes

  key :name, String
  belongs_to :content_type, :class_name => "Structure::ContentType"

  private
  def write_routes
  	filename = File.join("config", "routes.rb")
  	File.open(filename, "w+") do |f|
  		f << "Cms::Application.routes.draw do\n"
  		# Structure Routes
  		f << "	namespace :structure do\n"
  		f << "		resources :content_types\n"
  		f << "		resources :pages\n"
  		f << "		resources :contents\n"
  		f << "	end\n"
  		# Content Routes
  		Structure::Page.all.each do |page|
  			f << "	resources :" + page.name.downcase.pluralize + "\n"
  		end
  		f << "end"
  	end
  end

  private
  def write_controller_file
  	modelname = self.content_type.name.singularize.tr(' ','_').camelize
  	variablename = self.content_type.name.downcase
  	filename = File.join("app", "controllers", self.name.downcase.pluralize + "_controller.rb")
  	File.open(filename, "w+") do |f|
  		f <<
"class #{self.name.pluralize.camelize}Controller < ApplicationController
	def index
		@#{variablename.pluralize} = #{modelname}.all
		respond_to do |format|
			format.html { render json: @#{variablename.pluralize} }
		end
	end

	def show
		@#{variablename.singularize} = #{modelname}.find(params[:id])
		respond_to do |format|
			format.html { render json: @#{variablename.singularize} }
		end
	end
end"
  	end
  end
end
