//pagedown bootstrap (https://github.com/hughevans/pagedown-bootstrap-rails)

//= require marked
//= require marked.editor


//sync title input and title on demo post; has to be fired on document ready or it won't find the proper elements
jQuery(document).ready(function(){
	//Sync title with title field
	$('#post_title').bind('input propertychange', function() {
	    $('#title').text(this.value);
	});
	//initialize marked, which is required for the editor to work
	marked.setOptions({
	  gfm: true,
	  tables: true,
	  breaks: true,
	  pedantic: false,
	  sanitize: false,
	  smartLists: false,
	  smartypants: false,
	});
	editor = new Markdown.Editor('#post_content_html');
    return editor.run();
 });