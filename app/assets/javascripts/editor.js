//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.miniColors
//= require gmap3.min
//= require_self 

//prepare document
$('#imageEdit').hide();
$('#textControl').hide();
$('#linkEdit').hide();
$('#mapEdit').hide();
$('#codeEdit').hide();

$('#page_list li a').click(function(){return false;});
bindImages();
bindLinks();
mapInit();
$('#up_submit').click(saveContent);
buttonUp();
bindBody();
bindCodeBlocks();

// HIDE/SHOW CONTROLS BASED ON THE WHERE THE CLICK WAS
function bindBody(){
	$('body').click(function(evt) {
    	var target = $(evt.target)
   	
    	//check to see if click is not on an image, in the imageedit area, a field
    	if($('#imageEdit').is(':visible') && target.is(':not(img, #imageEdit, .imageField, #imageEdit *)')){
    		$('#image_settings').show();
    		$('#MyImages').hide();
    		$('#imageEdit').hide();
    	}
  	      	
   		//check to see if the click is on a text element in the edit box
	    if(target.is("#box p,#box h1,#box h2,#box h3,#box h4,#box h5,#box h6,#box h7,#box ol, #box ul, #box li, #box span, #box sub, #box sup, .textBtn, input, .miniColors, .miniColors-trigger, .miniColors-selector,.miniColors-huePicker,.miniColors-hues,.miniColors-colorPicker-inner,.miniColors-colorPicker,#colors label, #colors, #colors input, #colors a,#fonts,#fonts select, #fonts option")){
	       if(target.is(":not(.textBtn,.miniColors, .miniColors-trigger, .miniColors-selector,.miniColors-huePicker,.miniColors-hues,.miniColors-colorPicker-inner,.miniColors-colorPicker,#colors label, #colors, #colors input, #colors a,#fonts,#fonts select, #fonts option, #imageEdit, .imageField,#linkEdit,.linkField, .map_control, .code_block, .code_block *)")){
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
	    if ($('#linkEdit').is(':visible') && target.is(':not(a, #linkEdit,.linkField,.link_control, .link_control option, .miniColors, .miniColors-trigger, .miniColors-selector,.miniColors-huePicker,.miniColors-hues,.miniColors-colorPicker-inner,.miniColors-colorPicker)')){
	       $('#linkEdit').hide(); 
	    }
	    
	    //check to see if the click is on a code block in the box
	    if ($('#codeEdit').is(':visible') && target.is(':not(#codeEdit,#codeEdit label,#code_text, .code_block, .code_block *)')){
	       $('#codeEdit').hide(); 
	    }
	    
	    //check to see if the click is on map in the box
	    if ($('#mapEdit').is(':visible') && target.is(':not(.map,.map div, .map div div, #mapEdit, .map_control, .map_control li)')){
	       $('#mapEdit').hide(); 
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
	}else if (type == 'map_c'){
		var fig = createFigure().addClass('map_f').appendTo('#box');
		var map = createMap().appendTo(fig);
		createFigCaption().appendTo(fig);
		map.gmap3();
		bindMaps();
	}else if (type == 'map'){
		var fig = createFigure().addClass('map_f').appendTo('#box');
		var map = createMap().appendTo(fig);
		map.gmap3();
		bindMaps();
	}else if(type == 'hr'){
		var div = createDiv().appendTo('#box');
		createHR().appendTo(div);
	}else if(type == 'code'){
		createCode().appendTo('#box').click(editCode);
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

function createHR(){
	var hr = $(document.createElement('hr'));
	return hr;
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

function createMap(){
	var map = $(document.createElement("div")).addClass('map ms').attr('data-size','ms').attr('data-address','').attr('data-zoom','8').attr('contenteditible','false').click(editMap);
	return map;
}
		
function createCode(){
	var code = createDiv().attr('contenteditible','false').addClass('code_block').html('<p>Click on the code inside the code block to edit the settings. Be sure to paste all code exactly as it appears.</p>');
	return code;
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
	$('.image').click(updateMyImage);
}

function updateMyImage(){
	var loc = $(this).attr('data-url');
    var alt = $(this).attr('data-title');
    var title = $(this).attr('data-alt');
	
	$('#location').val(loc);
    $('#alttext').val(alt);
    $('#title').val(title);
	
	updateImage();
}
        
function updateImage(){
    var loc = $('#location').val();
    var alt = $('#alttext').val();
    var title = $('#title').val();
    image_store.attr('src',loc).attr('alt',alt).attr('title',title);
}

function readyImageBar(image){
	$('#my_images').hide();
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

function showMyImages(){
	$('#image_settings').toggle();
	$('#my_images').toggle();
}

function floatImage(type){
		image_store.attr('class',type).parent('figure').attr('class',type).children('figcaption').attr('class',type);
}

function destroyImage(){
	image_store.remove();
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
						of:link,
						offset:"0px -25px"
					}).show();
    $('#a_colors').hide();
    $('#a_fonts').hide();
    $('#href').focus();
}
        
function updateLink(){
   link_store.text($('#lText').val()).attr('href',$('#href').val());
}

$('#a_color_store').miniColors({
					change: function(hex,rgb){
						changeColorA(hex);
					}
				});
$('#a_bg_color_store').miniColors({
					change: function(hex,rgb){
						changeBackColorA(hex);
					}
				});
				
$('#a_font_store').change(changeFontA);
$('#a_font_size_store').change(changeFontSizeA);

function showColorBarA(){
	$('#a_fonts').hide();
	$('#a_colors').toggle();
}

function changeColorA(hex){
	link_store.css('color',hex);
}

function changeBackColorA(hex){
	link_store.css('backgroundColor',hex);
}

function showFontBarA(){
	$('#a_colors').hide();
	$('#a_fonts').toggle();
}

function changeFontA(){
	var font = $('#a_font_store').val();
	link_store.css('fontFamily',font);
}

function changeFontSizeA(){
	var size = $('#a_font_size_store').val();
	link_store.css('fontSize',size);
}

function linkCss(type){
	link_store.toggleClass(type);
}

function floatLink(type){
	link_store.removeClass('aleft aright acenter fleft fright').addClass(type);
}
	

function destroyLink(){
	link_store.remove();
}
       
//SAVE CHANGES FUNCTIONS
function saveContent(){
     $('#page_content').val($('#box').html());
}

//UI BUTTON CALLS
function buttonUp(){
	$('#textControl button').button();
	$('#linkEdit button').button();
	$('#mapEdit button').button();
	$('#imageEdit button').button();
	$('#codeEdit button').button();
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
		$('div > hr').parent().each(function(){$(document.createElement('img')).attr('src','/assets/draggable.png').addClass('drag_img').appendTo(this);});
		sort_state="end";
	} else if(sort_state=="end"){
		$('#sort button').button("option", "icons",{primary: "ui-icon-arrowthick-2-n-s"});
		$('#box').attr('contenteditable','true').sortable("option","disabled",true);
		$('.drag_img').remove();
		bindLinks();
		bindImages();
		bindBody();
		sort_state="start";
	}
}

//MAP EDITOR FUNCTIONS
var map = ""

function mapInit(){
	$('.map').each(function(){
			map = this;
			address = $(map).attr('data-address');
			zoom = parseInt($(map).attr('data-zoom'));
			$(map).gmap3(
				{action:'clear', name:'marker'},
				{
					action: 'addMarker',
					address: address,
					map:{
					center:true,
					zoom: zoom
					}
				}
			);
		});
	bindMaps();	
}

function editMap(){
	map = this
	
	//set the value of the fields = to attributes
    var add = $(map).attr('data-address');
    $('#address').val(add);
    var zoom = $(map).attr('data-zoom');
    $('#zoom').val(zoom);
    var size = $(map).attr('data-size');
    $('#map_size').val(size);
            
    //move and display the map edit bar
    readyMapBar(map); 
	
	//add event listeners
	$('#address').change(updateMap);
	$('#zoom').change(updateMap);
	$('#map_size').change(changeMapSize);
}

function readyMapBar(map){
	$('#mapEdit').position({
						my:"left bottom",
						at:"left top",
						of:map
					}).show();
    $('#address').focus();
}

function bindMaps(){
	$('.map').click(editMap);
}

function updateMap(){
	var address = $('#address').val();
	$(map).attr('data-address', address);
	var zoom	= $('#zoom').val();
	$(map).attr('data-zoom', zoom);
	var zoom	= parseInt(zoom);
					
	//update map
	$(map).gmap3(
		{action:'clear', name:'marker'},
		{
			action: 'addMarker',
			address: address,
			map:{
			center:true,
			zoom: zoom
			},
		}
	);
}

function changeMapSize(){
	var code = $('#map_size').val();
	$(map).attr('data-size', code).attr('class',code + " map");
}

function floatMap(type){
		$(map).removeClass('aleft aright acenter fleft fright').addClass(type).parent('figure').children('figcaption').attr('class',type);
}

function destroyMap(){
	$(map).gmap3('destroy').remove();
}

//EDIT CODE FUNCTION
var code_block = "";	
function editCode(){
	code_block = this;
	
	var code = $(this).html();
	$('#code_text').val(code);
	
	readyCodeBar();
}

function readyCodeBar(){
	$('#codeEdit').position({
						my:"left bottom",
						at:"left top",
						of:code_block
					}).show();
    $('#code_text').focus();
}

function insertCode(){
	var code = $('#code_text').val();
	$(code_block).html(code);
}

function bindCodeBlocks(){
	$('.code_block').click(editCode);
}

function floatCode(type){
		$(code_block).removeClass('aleft aright acenter fleft fright').addClass(type).parent('figure').children('figcaption').attr('class',type);
}

function destroyCode(){
	$(code_block).remove();
}

//SAMPLE TEXT FOR CREATES
var p_sample_text = "Click to edit this text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut arcu nibh, condimentum non iaculis vel, dictum eleifend leo. Quisque placerat hendrerit interdum. Curabitur dapibus, purus eget varius volutpat, dolor erat auctor felis, at tristique magna mauris ac nisi. Cras felis lorem, pellentesque nec porta in, eleifend eget elit. Vivamus ipsum metus, cursus vel dignissim sit amet, volutpat sed diam. Curabitur at sem vitae dui sagittis lacinia vitae eu tortor. Nunc diam est, porta eget varius et, egestas varius urna."
var h_sample_text = "Click to edit this text.Ut arcu nibh, condimentum non iaculis."