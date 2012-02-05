class Relationship
  include MongoMapper::Document

  key :type, Integer

  belongs_to :from, :class_name => 'ContentType', :typecast => 'ObjectId'
  belongs_to :to, :class_name => 'ContentType', :typecast => 'ObjectId'
end