class Structure::ContentType
  include MongoMapper::Document
  after_save :write_to_file, :update_children
  after_destroy :remove_file, :update_children, :update_parents

  key :name, String

  # Embedded Keys
  many :relationships, :class_name => 'Structure::Relationship'
  many :fields, :class_name => 'Structure::Field'
  many :pages, :class_name => 'Structure::Page'

  def from
    Structure::ContentType.where('relationships.to_id' => self._id).all
  end

  # Necessary?
  def pages
    Structure::Page.where('content_type_id' => self._id).all
  end

  def update_embedded_documents(params)
    if params[:fields] == nil
      self.fields = []
      changed = true
    end
    if params[:relationships] == nil
      self.relationships = []
      changed = true
    end
    if changed
      self.save
    end
    return true
  end

  def write_to_file
    # name standardized
    name = self.name.singularize.tr(' ','_')
    model_name = name.camelize
    filename = File.join('app', 'models', (name.underscore + '.rb'))
    File.open(filename, 'w+') do |f|
      # Class declaration
      f << "class #{model_name}\n"
      f << "\tinclude MongoMapper::Document\n"
      # Fields
      self.fields.each do |field|
        if (Structure::Field.get_type_options[field.type] == 'Timestamp')
          f << "\ttimestamps!\n"
        else
          f << "\tkey :" + field.title.singularize.tr(' ','_').underscore + ", String\n"
        end
      end
      # Children Relationships
      self.relationships.each do |relationship|
       f << "\tmany :" + relationship.to.name.pluralize.tr(' ','_').underscore + "\n"
      end
      # Parent Relationships
      self.from.each do |content_type|
       f << "\tbelongs_to :" + content_type.name.singularize.tr(' ','_').underscore + "\n"
      end
      f << "end"
    end
  end

  private
  def remove_file
    name = self.name.singularize.tr(' ','_')
    filename = File.join('app', 'models', (name.underscore + '.rb'))
    File.delete(filename)
  end

  private
  def update_children
    self.relationships.each do |relationship|
      relationship.to.write_to_file
    end
  end

  private
  def update_parents
    self.from.each do |content_type|
      # remove obsolete relationships
      content_type.relationships.each do |relationship|
        if relationship.to_id == self._id
          content_type.pull(:relationships => {:to_id => self._id})
        end
      end
      # rewrite model file
      content_type.reload
      content_type.write_to_file
    end
  end
end
