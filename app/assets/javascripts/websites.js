hidePageForms();

$('.page_li').click(showPageForm);

function showPageForm(){
	var li = $(this)
	
	//hide all previous forms and links
	hidePageForms();
	
	li.children().show();
	var page_num = li.attr('id');
	$('#page_form_'+ page_num).show();
}


function hidePageForms() {
	$('.page_form').hide();
	$('.page_li a').hide();
}
