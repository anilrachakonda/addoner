# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready (e) ->
	$("#cancel_extn").on 'click', (e) ->
		window.location.href = '/'
		true
	$("#sample-extension").on 'click', (e) ->
		browser_type = $("#browser_type").val()
		location.href = "/addoners/download_sample_extension?browser_type="+browser_type

		true
	$("#extn").on 'click', (e) ->
		browser_type = $("#browser_type").val()
		user_code=escape(tinymce.get('user-code').getContent())
		location.href = '/addoners/generate_extension?browser_type='+browser_type+'&user_code='+user_code