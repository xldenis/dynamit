App.controller('feed', function($scope, $http, $templateCache) {
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
	
	$scope.method = 'GET';
	$scope.url = 'http://angularjs.org/greet.php?callback=JSON_CALLBACK&name=Super%20Hero';
	$scope.url = 'http://localhost:3000/welcome.json';
	
	$scope.fetch = function() {
		$scope.code = null;
		$scope.response = null;
		
		$http({method: $scope.method, url: $scope.url}).
		success(function(data, status) {
			$scope.status = status;
			$scope.data = data;
			$scope.posts = data;
		}).
		error(function(data, status,headers,config) {
			$scope.data = data || "Request failed";
			$scope.status = status;
		});
	};
	
	$scope.updateModel = function(method, url) {
		$scope.method = method;
		$scope.url = url;
	};
	
	
	$scope.removeSource = function(source) {
		angular.forEach($scope.posts, function(post) {
			if(post.source === source) {
				post.visible = false;
				post.content = 'this should be removed';
			}
		});
	};
	
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
