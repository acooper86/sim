//= require jquery
//= require jquery_ujs
//= require_self 

//prepare document
$('#imageEdit').hide();
$('#textControl').hide();
$('#linkEdit').hide();
$('#page_list li a').click(function(){return false;})
bindImages();
bindLinks();
$('#up_submit').click(saveContent);

// HIDE/SHOW CONTROLS BASED ON THE WHERE THE CLICK WAS
$('body').click(function (evt) {
    var target = $(evt.target)
   	
    //check to see if click is not on an image, in the imageedit area, a field
    if($('#imageEdit').is(':visible') && target.is(':not(img, #imageEdit, .imageField)')){
    	$('#imageEdit').hide();
    }
        	
    //check to see if the click is on a text element in the edit box
    if(target.is("#box p,#box h1,#box h2,#box h3,#box h4,#box h5,#box h6,#box h7,#box ol, #box ul, #box li, #box span, .textBtn")){
        $('#textControl').show();
    } else {
        $('#textControl').hide();
    }
        	
    //check to see if the click is on an anchor in the box
    if ($('#linkEdit').is(':visible') && target.is(':not(a, #linkEdit,.linkField)')){
       $('#linkEdit').hide(); 
    }
})
		
//NEW ELEMENT FUNCTIONS
function newImage() {
	$(document.createElement("img")).attr('title','Hello There').attr('src',"/assets/image.png").attr('alt','Placeholder Image').click(editImage).appendTo('#box');
}
function newText (type) {
	$(document.createElement(type)).text('click to edit').appendTo('#box');
}
function newA (){
	var range = getRange();
	var new_anchor = document.createElement("a");
    new_anchor.setAttribute("href", "simplissage.com");
    range.surroundContents(new_anchor);
    bindLinks();
}
		
//EDIT TEXT COMMANDS
function txtC(c) {
	document.execCommand(c,false, null);
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
            
    //display the image edit bar
    $('#imageEdit').show();
    $('#location').focus(); 
            
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
       
function bindImages(){
    $('#box img').bind('click', editImage);
} 
       
//LINK FUNCTIONS
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
            
    //display the link edit bar
    $('#linkEdit').show();
    $('#href').focus(); 
            
    //add event listeners
    $('#href').change(updateLink);
    $('#lText').change(updateLink);
}
        
function updateLink(){
   link_store.text($('#lText').val()).attr('href',$('#href').val());
}
        
//SAVE CHANGES FUNCTIONS
function saveContent(){
     $('#page_content').val($('#box').html());
}