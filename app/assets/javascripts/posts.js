$(function() {
  return $('a.load-more-posts').on('inview', function(e, visible) { 
    if (!visible) { //the if(!visible) is because 'inview' fires when the element comes into AND GOES OUT OF view
      return;
    }
    return $.getScript($(this).attr('href'));
  });
});
