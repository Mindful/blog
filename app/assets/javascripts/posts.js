//pagedown bootstrap (https://github.com/hughevans/pagedown-bootstrap-rails)

//= require pagedown_bootstrap

//pagedown_bootstrap initialization function
$(function() {
  return $('textarea.wmd-input').each(function(i, input) {
    var attr, converter, editor;
    attr = $(input).attr('id').split('wmd-input')[1];
    converter = new Markdown.Converter();
    editor = new Markdown.Editor(converter, attr);
    return editor.run();
  });
});

//sync title input and title on demo post; has to be fired on document ready or it won't find the proper elements
jQuery(document).ready(function(){
	$('#post_title').bind('input propertychange', function() {
	    $('#title').text(this.value);
	});
 });