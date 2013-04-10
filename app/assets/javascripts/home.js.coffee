# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready (e) ->
	#browser type drop down selection
	$("select#browser").on 'change', (e) ->
		if($(this).val().toLowerCase() == "firefox" || $(this).val().toLowerCase() == "chrome")
			window.location.href = '/addoners/create_extension?browser_type='+$(this).val().toLowerCase()
