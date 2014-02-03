$( document ).ready(function() {
    if (($(document).attr('title') != "UrbanHop | Help") && $(document).attr('title')!="UrbanHop | Home") {
    	$('.container>.row-fluid').height(515);
    }
    $('textarea').autosize({append: "\n"});   
    
    if (($(document).attr('title') === "UrbanHop | Home") && $('#nav_home').length === 0) {
		
		$('#Home>.container').css({"width":"100%","margin-top":"-19px"});
		$('.footer').css({"width":"95%","margin-left":"2.5%"});
		
		$('.slideshow').cycle({
			fx: 'fade',
			containerResize: false,
  			slideResize: false,
  			random: true,
  			width: '100%',
  			fit: 1
		});				

		if ($(window).width() <= 800) {
			var offset = Math.round($(window).width()/2 - 224);
			var offsetString = 'calc(50% + ' + offset + 'px)';
			console.log(offsetString);
			$('.home_box>.span12').height(0.625*$(window).width());
			$('#sign_up').css('margin-left',offsetString);
			
		} else {
			var offsetString = 'calc(50% + ' + 176 + 'px)';
			$('#sign_up').css('margin-left',offsetString);
		}
    }
    
    if (($(document).attr('title') === "UrbanHop | Home") && $('#nav_home').length > 0) {
//		var trending = ['/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png','/assets/rails.png'];

//    	for(i = 0; i < trending.length; i++){
//			$('#trending_items').append("<img src='" + trending[i] + "' class='newsfeed_pic'>");
//		}
		


		$('#trending').smoothDivScroll({
			//mousewheelScrolling: "allDirections",
			visibleHotSpotBackgrounds:"always",
			mousewheelScrollingStep: 10,
			easingAfterMouseWheelScrolling: true,
			manualContinuousScrolling: false
		});
		$('#latest').smoothDivScroll({
			//mousewheelScrolling: "allDirections",
			visibleHotSpotBackgrounds:"always",
			mousewheelScrollingStep: 10,
			easingAfterMouseWheelScrolling: true,
			manualContinuousScrolling: false
		});
		$('#following').smoothDivScroll({
			//mousewheelScrolling: "allDirections",
			visibleHotSpotBackgrounds:"always",
			mousewheelScrollingStep: 10,
			easingAfterMouseWheelScrolling: true,
			manualContinuousScrolling: false
		});
		
		//$('#trending_items').css('width','5000px');
		
    }
});




/* helper methods */

function randint(n){
	return Math.floor(Math.random()*n);
}

function randperm(n){
	if (n === 1){
		return [0];
	}
	perm = randperm(n-1);
	r = randint(n);
	perm.push(perm[r]);
	perm[r] = n-1;
	return perm;
}

function fade(){
	//$('#picture' + (index%pictures.length)).css("opacity","0");
	$('#picture' + (index%pictures.length)).fadeOut(0.0001);
	$('#picture' + (index%pictures.length)).css("z-index",index+"");
	$('#picture' + (index%pictures.length)).fadeIn(1000);
	index += 1;
	setTimeout(fade, 6000);
}

function positionHome() {
	var maxHeight = Math.max.apply(null, $(".slideshow_image").map(function () {
    	return $(this).height();
	}).get());
    $('.home_box>.span12').height(maxHeight);
    
    var maxWidth = Math.max.apply(null, $(".slideshow_image").map(function () {
    	return $(this).width();
	}).get());
	
	var offset = Math.round(maxWidth/2 - 224);
	var offsetString = 'calc(50% + ' + offset + 'px)';
	
	$('#sign_up').css('margin-left',offsetString);
}

$(window).resize(function() {
	positionHome();
});

/*
$(window).trigger('resize');
var canvas, stage, exportRoot;

function init() {
	canvas = document.getElementById("canvas");
	exportRoot = new lib.generateanaction();

	stage = new createjs.Stage(canvas);
	stage.addChild(exportRoot);
	stage.update();
	stage.enableMouseOver();

	createjs.Ticker.setFPS(lib.properties.fps);
	createjs.Ticker.addEventListener("tick", stage);
}
*/