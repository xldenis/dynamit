App.controller('track', function($scope, $http) {
	var trackingData = [];
	$scope.$on('scrollStopped', function(event, args) {
		alert('scrollStopped with message: ' + args.message);
	});
});