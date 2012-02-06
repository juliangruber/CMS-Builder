module ContentTypesHelper
	def add_field_link(title, f, field)
    	# TODO: Fix embedded js
    	link_to_function(title, '$(\'#fields\').append(\'' + escape_javascript(render(:partial => 'field', :locals => {:f => f, :field => field})) +  '\')')
  end
end
