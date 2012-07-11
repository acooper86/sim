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

//sortable functions
$('#pagesList ul').sortable({
	update: createOrder
});

$('#save_order').hide();

function showSaveOrder() {
	$('#save_order').show();
	hidePageForms();
}

function createOrder() {
	var order_string = "[";
	$('.page_li').each(function(i,elem){
		if (i != 0) {order_string += ","};
		order_string += $(elem).attr('id');
	});
	
	order_string += "]";
	
	updateOrder(order_string);
	if ($('#save_order:hidden')) {
		$('#save_order').show();
	}
}

function updateOrder(string){
	$('#website_order').val(string);
}

//create pretty button styles
$('#publish_button').button();
$('form input[type=submit]').button();
$('.page_button').button();
$('.delete').button({icons:{primary:'ui-icon-trash'}, text:false});
$('.show').button({icons:{primary:'ui-icon-newwin'}, text:false});
$('.edit').button({icons:{primary:'ui-icon-pencil'}, text:false});