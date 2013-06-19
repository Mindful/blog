//pagedown bootstrap (https://github.com/hughevans/pagedown-bootstrap-rails)

//= require pagedown_bootstrap


//sync title input and title on demo post; has to be fired on document ready or it won't find the proper elements
jQuery(document).ready(function(){
	//Sync title with title field
	$('#post_title').bind('input propertychange', function() {
	    $('#title').text(this.value);
	});
	//pagedown_bootstrap initialization function
	var converter, editor;;
    converter = new Markdown.Converter();
    editor = new Markdown.Editor(converter);
    //Sync hidden input with generated html
	converter.hooks.chain("postConversion", function (text) {
        $('#post_content_html').val(text);
        return text;
    });
    return editor.run();
 });