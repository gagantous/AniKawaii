if((navigator.userAgent.match(/iPad/i)) && (navigator.userAgent.match(/iPad/i)!= null)){
  		
		$('video').prop("controls",true);
	}



 (function(d, t) {
    var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
    g.src = 'https://assets.gfycat.com/js/gfyajax-0.517d.js';
    s.parentNode.insertBefore(g, s);
}(document, 'script'));

$(document).on('mouseenter','.video', hoverVideo ).on('mouseleave','.video',hideVideo );
	function hoverVideo(e) {
		$('video',this).get(0).play();
		$('header',this).hide();
	}

	function hideVideo(e) {
		$('video',this).get(0).pause();
		$('header',this).show();
	}


