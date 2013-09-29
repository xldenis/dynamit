App.directive('whenScrolled', function() {
	return function(scope, elm, attr) {
		//bound to window because window has a scroll bar
		//scroll event is only called on element when it has a scroll bar
		var element = $(window);
		element.bind('scroll', function() {
			if (element.data('scrollTimeout')) {
				clearTimeout(element.data('scrollTimeout'));
			}
			
			element.data('scrollTimeout', setTimeout(scope.scrollStopped,250,element));
		});
	};
});