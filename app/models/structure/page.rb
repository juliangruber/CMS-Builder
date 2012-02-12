class Structure::Page
  include MongoMapper::Document
  after_save :unique_homepage, :write_routes, :write_controller_file
  #before_destroy :delete_controller_file
  after_destroy :write_routes, :unique_homepage

  key :name, String
  key :is_homepage, Integer
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
      # Set homepage
      f << "  match '/', :controller => :" + Structure::Page.where(:is_homepage => 1).sort(:updated_at.desc).first.name.downcase.pluralize + ", :action => :index\n"
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

  private
  def unique_homepage
    with_homepage_set = Structure::Page.where(:is_homepage => 1).sort(:updated_at.desc).all
    # no page with homepage
    if with_homepage_set.size == 0
      page = Structure::Page.sort(:updated_at.desc).first
      page.is_homepage = 1
      page.save
    # set to first
    elsif with_homepage_set.size > 1
      # unset all
      with_homepage_set.each do |page|
        p = page
        p.is_homepage = 0
        p.save
      end
      # set first to homepage
      page = with_homepage_set.first
      page.is_homepage = 1
      page.save
    end
  end
end
