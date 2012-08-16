// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	$('#notification_form')
		.bind("ajax:beforeSend", function(){
			console.log("proccessing")
		})
		.bind("ajax:success", function(event, data, status, xhr){
			console.log(status);
			console.log(data);
			var edit_button = "<a href='/notifications/"+data.notification.id+"/edit'>Edit</a>"
			var delete_button = "<a href='/notifications/"+data.notification.id+"', data-method='delete', data-confirm='Are you sure.'>Delete</a>"
			var tr = "<tr><td>"+data.notification.body + "</td><td>"+data.notification.time +"</td><td>"+ edit_button + delete_button +"</td></tr>"
			$( "#my-notifications").append(tr)
			console.log(tr)
		});
		
});