module ContentTypesHelper
	def add_field_link(title, f)
    	# TODO: Fix embedded js
    	link_to_function(title, '$(\'#fields\').append(\'' + escape_javascript(render(:partial => 'field', :locals => {:f => f, :field => Structure::Field.new})) +  '\')')
  	end

  	def add_relationship_link(title, f)
    	# TODO: DRY
    	link_to_function(title, '$(\'#relationships\').append(\'' + escape_javascript(render(:partial => 'relationship', :locals => {:f => f, :relationship => Structure::Relationship.new})) +  '\')')
  	end
end
