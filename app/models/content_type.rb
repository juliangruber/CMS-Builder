class ContentType
  include MongoMapper::Document

  key :name, String

  key :relationship_ids, Array
  many :relationships, :in => :relaionship_ids

  def self.add_relationship(relationship)
  	self.find([relationship.from_id, relationship.to_id]).each do |rel|
          rel.relationship_ids << relationship._id
          rel.save
        end
  end
end
