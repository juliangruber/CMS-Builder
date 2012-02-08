class Structure::PagesController < ApplicationController
  # GET /structure/pages
  # GET /structure/pages.json
  def index
    @structure_pages = Structure::Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @structure_pages }
    end
  end

  # GET /structure/pages/1
  # GET /structure/pages/1.json
  def show
    @structure_page = Structure::Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @structure_page }
    end
  end

  # GET /structure/pages/new
  # GET /structure/pages/new.json
  def new
    @structure_page = Structure::Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @structure_page }
    end
  end

  # GET /structure/pages/1/edit
  def edit
    @structure_page = Structure::Page.find(params[:id])
  end

  # POST /structure/pages
  # POST /structure/pages.json
  def create
    @structure_page = Structure::Page.new(params[:structure_page])

    respond_to do |format|
      if @structure_page.save
        format.html { redirect_to @structure_page, notice: 'Page was successfully created.' }
        format.json { render json: @structure_page, status: :created, location: @structure_page }
      else
        format.html { render action: "new" }
        format.json { render json: @structure_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /structure/pages/1
  # PUT /structure/pages/1.json
  def update
    @structure_page = Structure::Page.find(params[:id])

    respond_to do |format|
      if @structure_page.update_attributes(params[:structure_page])
        format.html { redirect_to @structure_page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @structure_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /structure/pages/1
  # DELETE /structure/pages/1.json
  def destroy
    @structure_page = Structure::Page.find(params[:id])
    @structure_page.destroy

    respond_to do |format|
      format.html { redirect_to structure_pages_url }
      format.json { head :no_content }
    end
  end
end
