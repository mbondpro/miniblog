function focus() {
	$(document).ready(function(){
		$('body :not(".comment_form"):input:visible:enabled:first').focus(); 
	});
}