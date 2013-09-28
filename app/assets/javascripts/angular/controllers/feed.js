App.controller('feed', function($scope, $http, $templateCache) {
	$scope.sources = ['45c39c65757365a379020000', ];
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
	
	$scope.method = 'GET';
	$scope.url = 'http://localhost:3000/api/sources/45c39c65757365a379020000.json';
	
	//pull sources for the specified user
	$scope.getUsersSources = function(user_id) {
		var userSourcesURL = 'http://localhost:3000/api/users/'+user_id+'/sources/';
		$http.get(userSourcesURL).
		success(function(data, status) {
			$scope.sources = data;
		}).
		error(function(data, status) {
			alert('there was an error getting your sources');
		});
	};
	
	//pull posts from a source
	$scope.getPostsFromSource = function(source_id) {
		var sourceURL = 'http://localhost:3000/api/posts.json';
		$http.get(sourceURL).
		success(function(data, status) {
			
			$scope.posts.concat(data);
			angular.forEach(data, function(post) {
				post.post.created_time = new Date(post.post.created_time).toRelativeTime();
				$scope.posts.push(post);
			});
		}).
		error(function(data, status) {
			alert('there was an error getting posts for the source: '+source_id);
		});
	};
	
	$scope.fetch = function() {
		
		//pull all posts from every source
		angular.forEach($scope.sources, function(source) {
			$scope.getPostsFromSource(source);
		});
		
		
		
		/*
$scope.code = null;
		$scope.response = null;
		
		$http({method: $scope.method, url: $scope.url}).
		success(function(data, status) {
			$scope.status = status;
			$scope.data = data;
			$scope.posts = data.source.posts;
			$scope.feeds.push(data.source);
			angular.forEach($scope.posts, function(post) {
				post.post.created_time = new Date(post.post.created_time).toRelativeTime();
			});
		}).
		error(function(data, status,headers,config) {
			$scope.data = data || "Request failed";
			$scope.status = status;
		});
*/
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
