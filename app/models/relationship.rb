class Relationship
  include MongoMapper::Document

  key :type, Integer

  one :from, :class_name => 'ContentType'
  one :to, :class_name => 'ContentType'

  #def from
  	#"bla"
  #	ContentType.all
  #end
end