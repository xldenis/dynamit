App.controller('feed', ['$scope', function($scope) {
	$scope.posts = [
		{source:'Facebook', content:"Carlos liked your page", visible:true},
		{source:"Twitter", content:"Xavier tweeted about turkeys", visible:true}
	];
	
	$scope.numPosts = function() {
		var num = 0;
		angular.forEach($scope.posts, function(posts) {
			if(posts.visible == true) {
				num++;
			}
		});
		return num;
	};
	
	$scope.removeSource = function(source) {
		angular.forEach($scope.posts, function(post) {
			if(post.source === source) {
				post.visible = false;
				post.content = 'this should be removed';
			}
		});
	};
	
	$scope.loadData = function() {
		$http.get('angular/services/data.json').success(function(data) {
			alert(data);
			$scope.phones = data;
		});
	};
	
}]);