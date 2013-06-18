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
