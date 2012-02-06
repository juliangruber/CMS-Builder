class Relationship
  include MongoMapper::EmbeddedDocument

  key :type, Integer
  belongs_to :to, :class_name => 'ContentType'
end