App.controller('header', function($scope) {
	$scope.change = function(msg) {
		$scope.$emit('handleEmit', {message: $scope.searchTerm});
	};
	$scope.loadData = function() {
		$scope.$emit('emitLoadData', {message: ""});
	};
});