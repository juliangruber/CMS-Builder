$(document).ready(function() {
	$('#structure_page_content_type_id').change(function() {
		$.each($('#contents').data('contents'), function(index, value) {
			if ($('#structure_page_content_type_id').val() == value.id) {
				// value is the selected content_type
				$(value.contents).each(function(index, value) {
   			 		$('#structure_page_content_id').append(
        				$('<option></option>').val(value.id).html(value.title)
    				);
				});
				// exit the each loop
				return false;
			}
		})
	});
});