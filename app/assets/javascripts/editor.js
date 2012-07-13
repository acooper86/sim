//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.miniColors
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
	    if(target.is("#box p,#box h1,#box h2,#box h3,#box h4,#box h5,#box h6,#box h7,#box ol, #box ul, #box li, #box span, #box sub, #box sup, .textBtn, input, .miniColors, .miniColors-trigger, .miniColors-selector,.miniColors-huePicker,.miniColors-hues,.miniColors-colorPicker-inner,.miniColors-colorPicker,#colors label, #colors, #colors input, #colors a,#fonts,#fonts select, #fonts option")){
	       if(target.is(":not(.textBtn,.miniColors, .miniColors-trigger, .miniColors-selector,.miniColors-huePicker,.miniColors-hues,.miniColors-colorPicker-inner,.miniColors-colorPicker,#colors label, #colors, #colors input, #colors a,#fonts,#fonts select, #fonts option, #imageEdit, .imageField,#linkEdit,.linkField)")){
	       	if (target.parent().attr('id') == "box" ) {
	       		textClick(target,"0 -50");
	       	} else if (target.parent().is("li,ol,ul,p,h1,h2,h3,h4,h5,h6,h7")){
	       			textClick(target.parent(),"0 -50");
	       	} else {
	       		textClick(target.parent(),"0");
	       	}
	       }
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
function newElem(type) {
	//Depending on the type of element, fire series of create functions
	if (type=='n'){
		createImage().appendTo('#box');
	} else if(type=='c'){
		var fig = createFigure().appendTo('#box');
		createImage().appendTo(fig);
		createFigCaption().appendTo(fig);
	}else if(type=='x'){
		var div = createDiv().appendTo('#box');
		createImage().appendTo(div);
		createT('p').appendTo(div);
	}else if(type=='t'){
		var div = createDiv().appendTo('#box');
		createT('h1').appendTo(div);
		createImage().appendTo(div);
	}else if(type=='tc'){
		var div = createDiv().appendTo('#box');
		createT('h1').appendTo(div);
		var fig = createFigure().appendTo(div);
		createImage().appendTo(fig);
		createFigCaption().appendTo(fig);
	}else if(type=='tx'){
		var div = createDiv().appendTo('#box');
		createT('h1').appendTo(div);
		createImage().appendTo(div);
		createT('p').appendTo(div);
	}else if(type=='txc'){
		var div = createDiv().appendTo('#box');
		createT('h1').appendTo(div);
		var fig = createFigure().appendTo(div);
		createImage().appendTo(fig);
		createFigCaption().appendTo(fig);
		createT('p').appendTo(div);
	}else if(type == 'h1-p'){
		var div = createDiv().appendTo('#box');
		createT('h1').appendTo(div);
		createT('p').appendTo(div);
	}else if (type == "l"){
		var link = $(document.createElement('p')).text('New Link').appendTo('#box');
		link.replaceWith('<a href="simplissage.com">New Link</a>');
		bindLinks();
	}else if(type == 'p'||'h1'||'h2'||'h3'||'h4'||'h4'||'h6'||'h7'){
		createT(type).appendTo('#box');
	}
}

//ALL OF THE CREATE COMMAND FUNCTIONS
function createImage(){
	var new_image = $(document.createElement("img"))
			.attr('title','Hello There')
			.attr('src',"/assets/image.png")
			.attr('alt','Placeholder Image')
			.click(editImage);
	return new_image;
}

function createFigure(){
	var new_figure = $(document.createElement("figure"));
	return new_figure;
}

function createFigCaption(){
	var cap = $(document.createElement("figcaption")).html('<p>Sample Caption<p>');
	return cap;
}

function createDiv(){
	var div = $(document.createElement("div"));
	return div;
}

function createT(type){
	if(type=="p"){
		var sample = p_sample_text;
	} else {
		var sample = h_sample_text;
	}
	
	var t = $(document.createElement(type)).text(sample);
	return t;
}

		
//EDIT TEXT COMMANDS
function txtC(c) {
	document.execCommand(c,false, null);
}

//TEXT CONTROL FUNCTIONS
$('#color_store').miniColors({
					change: function(hex,rgb){
						changeColor("foreColor",hex);
					}
				});
$('#bg_color_store').miniColors({
					change: function(hex,rgb){
						changeBackColor("backColor",hex);
					}
				});
				
$('#font_store').change(changeFont);
$('#font_size_store').change(changeFontSize);

function textClick(parent,off){
	$('#textControl').position({
						my:"left bottom",
						at:"left top",
						of:parent,
						offset:off
					}).show();
	$('#colors').hide();
	$('#fonts').hide();
} 

function showColorBar(){
	$('#fonts').hide();
	$('#colors').toggle();
}

function changeColor(type,hex){
	document.execCommand(type,false,hex);
}

function changeBackColor(type,hex){
	if (document.queryCommandEnabled('hiliteColor')){
		var t = "hiliteColor";
	} else {
		var t = "backColor";
	}
	changeColor(t,hex);
}

function showFontBar(){
	$('#colors').hide();
	$('#fonts').toggle();
}

function changeFont(){
	var font = $('#font_store').val();
	document.execCommand("fontName",false,font);
}

function changeFontSize(){
	var font = $('#font_size_store').val();
	document.execCommand("fontSize",false,font);
}

function removeFormat(){
	document.execCommand("removeFormat",false,null);
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
	$('.image_menu_li').hide();
	$('.elem_menu_li').hide();
	$('#title_select').button({text:false, icons:{primary: "ui-icon-triangle-1-n"}}).click(showTitleMenu).parent().buttonset();
	$('#pic_select').button({text:false, icons:{primary: "ui-icon-triangle-1-n"}}).click(showPicMenu).parent().buttonset();
	$('#elem_select').button({text:false, icons:{primary: "ui-icon-triangle-1-n"}}).click(showElemMenu).parent().buttonset();

}

function showPicMenu(){
	if ($('.image_menu_li').is(':visible')){
		$('.image_menu_li').hide();
		$('#pic_select').button("option", "icons",{primary: "ui-icon-triangle-1-n"});
	} else {
		$('.image_menu_li').show();
		$('#pic_select').button("option", "icons",{primary: "ui-icon-triangle-1-s"});
	}
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

function showElemMenu(){
	if ($('.elem_menu_li').is(':visible')){
		$('.elem_menu_li').hide();
		$('#elem_select').button("option", "icons",{primary: "ui-icon-triangle-1-n"});
	} else {
		$('.elem_menu_li').show();
		$('#elem_select').button("option", "icons",{primary: "ui-icon-triangle-1-s"});
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
		$('body, #box img, #box a').off();
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

//SAMPLE TEXT FOR CREATES
var p_sample_text = "Click to edit this text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut arcu nibh, condimentum non iaculis vel, dictum eleifend leo. Quisque placerat hendrerit interdum. Curabitur dapibus, purus eget varius volutpat, dolor erat auctor felis, at tristique magna mauris ac nisi. Cras felis lorem, pellentesque nec porta in, eleifend eget elit. Vivamus ipsum metus, cursus vel dignissim sit amet, volutpat sed diam. Curabitur at sem vitae dui sagittis lacinia vitae eu tortor. Nunc diam est, porta eget varius et, egestas varius urna."
var h_sample_text = "Click to edit this text.Ut arcu nibh, condimentum non iaculis."