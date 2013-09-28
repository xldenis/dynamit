App.controller('feed', function($scope, $http, $templateCache) {
	$scope.posts = [];
	
	$scope.numPosts = function() {
		var num = 0;
		angular.forEach($scope.posts, function(posts) {
			if(posts.visible == true) {
				num++;
			}
		});
		return num;
	};
	
	//pull sources for the specified user
	$scope.getPosts = function() {
		var postURL = 'http://localhost:3000/api/posts.json';
		$http.get(postURL).
		success(function(data) {
			$scope.posts = data;
		}).
		error(function(data) {
			alert('there was an error getting your sources');
		});
	};
	
	$scope.fetch = function() {
		$scope.getPosts();		
	};
	
	//handle event communication between controllers
	
	$scope.$on('handleBroadcast', function(event, args) {
		angular.forEach($scope.posts, function(post) {
			if(post.content.search(args.message) < 0) {
				post.visible = false;
			}
			else {
				post.visible = true;
			}
		});
	});
	
	$scope.$on('broadcastLoadData', function(event, args) {
		$scope.fetch();
	});
});