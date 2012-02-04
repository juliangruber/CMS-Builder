class ContentType
  include MongoMapper::Document

  key :name, String
  key :relationship_id

  belongs_to :relationship
end
