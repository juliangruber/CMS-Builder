#class MongoModels
#  def self.all
#    @@models ||= []
#  end
#end
#
#module MongoMapper
#  module Document
#    def self.included(klass) 
#      MongoModels.all << klass
#    end
#  end
#end

Dir[Rails.root + 'app/models/**/*.rb'].each do |path|
  require path
end
