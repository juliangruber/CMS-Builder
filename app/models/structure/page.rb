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
  		f << "\tnamespace :structure do\n"
  		f << "\t\tresources :content_types\n"
  		f << "\t\tresources :pages\n"
  		f << "\tend\n"
  		# Content Routes
  		Structure::Page.all.each do |page|
  			f << "\tresources :" + page.name.downcase.pluralize + "\n"
  		end
  		f << "end"
  	end
  end

  private
  def write_controller_file
  	filename = File.join("app", "controllers", self.name.downcase.pluralize + "_controller.rb")
  	File.open(filename, "w+") do |f|
  		f << "class #{self.name.pluralize.camelize}Controller < ApplicationController\n"
  		f << "\tdef index\n"
  		f << "\t\t@#{self.content_type.name.pluralize.downcase} = #{self.content_type.name.singularize.tr(' ','_').camelize}.all\n"
  		f << "\t\trespond_to do |format|\n"
  		f << "\t\t\tformat.html { render json: @#{self.content_type.name.pluralize.downcase} }\n"
  		f << "\t\tend\n"
  		f << "\tend\n"
  		f << "end\n"
  	end
  end
end
