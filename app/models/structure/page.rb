class Structure::Page
  include MongoMapper::Document

  key :name, String
  belongs_to :content_type, :class_name => 'Structure::ContentType'
end
