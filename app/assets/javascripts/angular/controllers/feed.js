App.controller('feed', function($scope, $http) {
	//array of time spent on each post
	var trackingData = [];
	
	//array of all posts
	$scope.posts = [];
	
	$scope.init = function () {
		$scope.getPosts();
	};

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
			//format time stamps nicely (ex. a few seconds ago)
			angular.forEach(data, function(post) {
				post.post.created_time = new Date(post.post.created_time).toRelativeTime();
			});
			
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
	
	$scope.scrollStopped = function() {
		console.log('hey scroll');
		
		//find which posts are visible
		$('.post').each(function(index, element) {
			if($scope.isVisible(element)) {
				trackingData.push($(element).attr('id'));
				//alert($(element).children('.postContent').text());
			}
		});
	}

	$scope.isVisible = function(element) {
		var docViewTop = $(window).scrollTop();
		var docViewBottom = docViewTop + $(window).height();
		
		var elemTop = $(element).offset().top;
		var elemBottom = elemTop + $(element).height();
		
		return ( (elemBottom >= docViewTop) && (elemTop <= docViewBottom) 
			  && (elemBottom <= docViewBottom) &&  (elemTop >= docViewTop) );
	}
});
