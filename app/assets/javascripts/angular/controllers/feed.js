App.controller('feed', function($scope, $http, $templateCache) {
	$scope.sources = ['e4c1d9637573657449030000', ];
	$scope.posts = [];
	
	//count
	$scope.numPosts = function() {
		var num = 0;
		angular.forEach($scope.posts, function(posts) {
			if(posts.visible == true) {
				num++;
			}
		});
		return num;
	};
	
	//get posts
	$scope.getPosts = function() {
		var userSourcesURL = 'http://localhost:3000/api/posts.json';
		$http.get(userSourcesURL).
		success(function(data, status) {
			$scope.posts.concat(data);
		}).
		error(function(data, status) {
			alert('there was an error getting your sources');
		});
	};
	
	$scope.fetch = function() {
		$scope.getPosts();
	};
	
	//handle event communication between controllers
	$scope.$on('searching', function() {
		alert("the user is searching for something");
	});
	
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
