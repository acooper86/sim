//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_self 

//prepare document
$('#imageEdit').hide();
$('#textControl').hide();
$('#linkEdit').hide();
$('#page_list li a').click(function(){return false;})
bindImages();
bindLinks();
$('#up_submit').click(saveContent);
buttonUp();

// HIDE/SHOW CONTROLS BASED ON THE WHERE THE CLICK WAS
bindBody();

function bindBody(){
	$('body').click(function(evt) {
    	var target = $(evt.target)
   	
    	//check to see if click is not on an image, in the imageedit area, a field
    	if($('#imageEdit').is(':visible') && target.is(':not(img, #imageEdit, .imageField)')){
    		$('#imageEdit').hide();
    	}
  	      	
   		//check to see if the click is on a text element in the edit box
	    if(target.is("#box p,#box h1,#box h2,#box h3,#box h4,#box h5,#box h6,#box h7,#box ol, #box ul, #box li, #box span, .textBtn")){
	       textClick();
	    } else {
	        $('#textControl').hide();
	    }
        	
	    //check to see if the click is on an anchor in the box
	    if ($('#linkEdit').is(':visible') && target.is(':not(a, #linkEdit,.linkField)')){
	       $('#linkEdit').hide(); 
	    }
	});
}
		
//NEW ELEMENT FUNCTIONS
function newImage(type) {
	if (type=='n'){
		$(document.createElement("img"))
			.attr('title','Hello There')
			.attr('src',"/assets/image.png")
			.attr('alt','Placeholder Image')
			.click(editImage)
			.appendTo('#box');
		}
	else if (type=='c'){
		var fig = $(document.createElement("figure")).appendTo('#box');;
		$(document.createElement("img"))
			.attr('title','Hello There')
			.attr('src',"/assets/image.png")
			.attr('alt','Placeholder Image')
			.click(editImage)
			.appendTo(fig);
		$(document.createElement("figcaption")).html('<p>Sample Caption<p>').appendTo(fig);
	}
}
function newText (type) {
	$(document.createElement(type)).text('click to edit').appendTo('#box');
}

function newLink (){
	var link = $(document.createElement('p')).text('New Link').appendTo('#box');
	link.replaceWith('<a href="simplissage.com">New Link</a>');
	bindLinks();
}
		
//EDIT TEXT COMMANDS
function txtC(c) {
	document.execCommand(c,false, null);
}

//TEXT CONTROL FUNCTIONS
function textClick(){
	$('#textControl').position({
						my:"left bottom",
						at:"left top",
						of:"#box"
					}).show();
}     
//EDIT IMAGE FUNCTIONS
var image_store = ''; 
function editImage(){
	//set the image# equal to dom index value 
    var image = this;
    image_store = $(image);
            
    //set the value of the fields = to attributes
    var loc = $(image).attr('src');
    $('#location').val(loc);
    var title = $(image).attr('title');
    $('#title').val(title);
    var alt = $(image).attr('alt');
    $('#alttext').val(alt);
            
    //move and display the image edit bar
    readyImageBar(image); 
            
    //add event listeners
    $('#location').change(updateImage);
    $('#title').change(updateImage);
    $('#alttext').change(updateImage);
}
        
function updateImage(){
    var loc = $('#location').val();
    var alt = $('#alttext').val();
    var title = $('#title').val();
    image_store.attr('src',loc).attr('alt',alt).attr('title',title);
}

function readyImageBar(image){
	$('#imageEdit').position({
						my:"left bottom",
						at:"left top",
						of:image
					}).show();
    $('#location').focus();
}
       
function bindImages(){
    $('#box img').bind('click', editImage);
} 
       
//LINK FUNCTIONS
function makeLink (){
	var range = getRange();
	var new_anchor = document.createElement("a");
    new_anchor.setAttribute("href", "simplissage.com");
    range.surroundContents(new_anchor);
    bindLinks();
}
function getRange(){
    //create the selection obj, or for IE the textrange
    var userSelection;
    if (window.getSelection) {
        userSelection = window.getSelection();
    } else if (document.selection){
        userSelection = document.selection.createRange();
    }
        	
    //create a range obj. from the selection obj.
    var rangeObject = getRangeObject(userSelection);
        	
    function getRangeObject(selectionObject) {
    	if (selectionObject.getRangeAt){
        	return selectionObject.getRangeAt(0);
        } else {
        	var range = document.createRange();
        	range.setStart(selectionObject.anchorNode,selectionObject.anchorOffset);
        	range.setEnd(selectionObject.focusNode,selectionObject.focusOffset);
        	return range;
        }
    }
	
    return rangeObject;
}
        
function bindLinks(){
    $('#box a').bind('click', editLink);
}
        
var link_store = ''; 
        
function editLink(){
    //store the link data
    var link = this;
    link_store = $(this);
            
    //set the value of the fields = to attributes
    var href = $(link).attr('href');
    $('#href').val(href);
            
    var text = $(link).text();
    $('#lText').val(text);
            
    //display and position the link edit bar
    readyLinkBar(link); 
            
    //add event listeners
    $('#href').change(updateLink);
    $('#lText').change(updateLink);
}

function readyLinkBar(link){
	$('#linkEdit').position({
						my:"left bottom",
						at:"left top",
						of:link
					}).show();
    $('#href').focus();
}
        
function updateLink(){
   link_store.text($('#lText').val()).attr('href',$('#href').val());
}
        
//SAVE CHANGES FUNCTIONS
function saveContent(){
     $('#page_content').val($('#box').html());
}

//UI BUTTON CALLS
function buttonUp(){
	$('#textControl button').button();
	staticMenuPrep();
	$('#staticControl button').button();
	$('#up_submit').button();
}

function staticMenuPrep(){
	$('.title_menu_li').hide();
	$('#title_select').button({text:false, icons:{primary: "ui-icon-triangle-1-n"}}).click(showTitleMenu).parent().buttonset();
}

function showTitleMenu(){
	if ($('.title_menu_li').is(':visible')){
		$('.title_menu_li').hide();
		$('#title_select').button("option", "icons",{primary: "ui-icon-triangle-1-n"});
	} else {
		$('.title_menu_li').show();
		$('#title_select').button("option", "icons",{primary: "ui-icon-triangle-1-s"});
	}
}

//SORT FUNCTIONS
$('#sort button').button("option", "icons",{primary: "ui-icon-arrowthick-2-n-s"}).click(toggleSort);
$('#box').sortable({disabled:true});

var sort_state = "start"
function toggleSort(){
	if(sort_state=="start"){
		$('#sort button').button("option", "icons",{primary: "ui-icon-cancel"});
		$('#box').attr('contenteditable','false').sortable("option", "disabled",false);
		$('body, img, a').off();
		sort_state="end";
	} else if(sort_state=="end"){
		$('#sort button').button("option", "icons",{primary: "ui-icon-arrowthick-2-n-s"});
		$('#box').attr('contenteditable','true').sortable("option","disabled",true);
		bindLinks();
		bindImages();
		bindBody();
		sort_state="start";
	}
}