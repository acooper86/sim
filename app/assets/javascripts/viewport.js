$('.map').each(function(){
  var map = $(this);
  var address = map.attr('data-address');
  var zoom = parseInt(map.attr('data-zoom'));

  map.gmap3(
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
