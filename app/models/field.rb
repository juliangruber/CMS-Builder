class Field
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :type, Integer

end
