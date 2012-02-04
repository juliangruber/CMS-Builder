class Relationship
  include MongoMapper::Document

  key :from, ObjectId
  key :to, ObjectId
  key :type, Integer

end
