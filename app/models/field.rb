class Field
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :type, Integer

  def self.get_type_options
	['Single line text', 'Multi line text', 'Timestamp']
	#[["Integer", 0], ["Single line text", 1], ["Multi line text", 2]]
  end
end
