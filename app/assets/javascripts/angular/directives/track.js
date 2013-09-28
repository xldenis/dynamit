App.directive('whenScrolled', function() {
	return function(scope, elm, attr) {
		//bound to window because window has a scroll bar
		//scroll event is only called on element when it has a scroll bar
		$(window).bind('scroll', function() {
			console.log('hey scroll');
		});
	};
});