//pagedown bootstrap (https://github.com/hughevans/pagedown-bootstrap-rails)

//= require marked
//= require marked.editor


//sync title input and title on demo post; has to be fired on document ready or it won't find the proper elements

String.prototype.titleize = function() {
    return $.trim(this.toLowerCase().replace(/(?:^|\s)\S/g, function(a) { return a.toUpperCase(); }));
};

String.prototype.categoryUrl = function() {
    return $.trim(this.toLowerCase());
};


jQuery(document).ready(function(){
	//Titleize the inputs
	var tagElement = $('#post_tag_list');
	tagElement.val(tagElement.val().titleize());
	tagElement = $('#post_category_list');
	tagElement.val(tagElement.val().titleize());
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
		$('#category').attr('href', '/category/'+categoryText.categoryUrl());
		$('#category').text(categoryText.titleize());
	})
	//Sync tags with tag field
	var tagList, tagListField, tagHash, tagUrl;
	$('#post_tag_list').bind('input propertychange', function()
	{
		tagHash = {}
		tagList = this.value.split(',');
		tagListField = $('#tags');
		tagListField.empty(); 
		//apend only if not == '' and if not found in hashtable (duplicate values)
		tagList.forEach(function(tag) {
			tagUrl = tag.categoryUrl();
			if (tag != '' && !tagHash[tagUrl])
			{
		    	tagListField.append('<a class="tag" href="/tag/'+tagUrl+'">'+tag.titleize()+'</a>  ');
		    	tagHash[tagUrl] = true;
			}
		});
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