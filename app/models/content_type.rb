class ContentType
  include MongoMapper::Document

  key :name, String

  # Embedded Keys
  many :relationships
  many :fields

  # def self.add_relationship(relationship)
  # 	self.find([relationship.from_id, relationship.to_id]).each do |rel|
  #         rel.relationship_ids << relationship._id
  #         rel.save
  #       end
  # end
end
