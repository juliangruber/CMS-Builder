class Structure::ContentsController < ApplicationController
  # GET /structure/contents
  # GET /structure/contents.json
  def index
    @contents = []
    Structure::ContentType.all.each do |content_type|
      obj = Object.const_get(content_type.name.capitalize)
      @contents.push({
        :name => content_type.name.pluralize,
        :contents => obj.all
        })
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contents }
    end
  end

  # GET /structure/contents/1
  # GET /structure/contents/1.json
  def show
    @structure_content = Structure::Content.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @structure_content }
    end
  end

  # GET /structure/contents/new
  # GET /structure/contents/new.json
  def new
    @structure_content = Structure::Content.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @structure_content }
    end
  end

  # GET /structure/contents/1/edit
  def edit
    @structure_content = Structure::Content.find(params[:id])
  end

  # POST /structure/contents
  # POST /structure/contents.json
  def create
    @structure_content = Structure::Content.new(params[:structure_content])

    respond_to do |format|
      if @structure_content.save
        format.html { redirect_to @structure_content, notice: 'Content was successfully created.' }
        format.json { render json: @structure_content, status: :created, location: @structure_content }
      else
        format.html { render action: "new" }
        format.json { render json: @structure_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /structure/contents/1
  # PUT /structure/contents/1.json
  def update
    @structure_content = Structure::Content.find(params[:id])

    respond_to do |format|
      if @structure_content.update_attributes(params[:structure_content])
        format.html { redirect_to @structure_content, notice: 'Content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @structure_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /structure/contents/1
  # DELETE /structure/contents/1.json
  def destroy
    @structure_content = Structure::Content.find(params[:id])
    @structure_content.destroy

    respond_to do |format|
      format.html { redirect_to structure_contents_url }
      format.json { head :no_content }
    end
  end
end
