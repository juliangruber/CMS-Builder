class Relationship
  include MongoMapper::EmbeddedDocument

  key :type, Integer
  belongs_to :to, :class_name => 'ContentType', :typecast => 'ObjectId'

  def self.get_type_options
	#[["has many", 0], ["has one", 1]]
	['has_many']
  end
end