//pagedown bootstrap (https://github.com/hughevans/pagedown-bootstrap-rails)

//= require marked
//= require marked.editor


//sync title input and title on demo post; has to be fired on document ready or it won't find the proper elements
jQuery(document).ready(function(){
	//Sync title with title field
	$('#post_title').bind('input propertychange', function() {
	    $('#title').text(this.value);
	});
	//Sync category with category field
	var commaIndex, categoryText;
	$('#post_category_list').bind('input propertychange', function()
	{
		commaIndex = this.value.indexOf(',');
		if (commaIndex == -1) categoryText = this.value;
		else categoryText = this.value.substring(0, commaIndex);
		$('#category').attr('href', '/category/'+categoryText);
		$('#category').text(categoryText);
	})
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