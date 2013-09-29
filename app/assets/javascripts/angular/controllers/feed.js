App.controller('feed', function($scope, $http) {
	//array of time spent on each post
	var trackingData = [];
	var currentPage = 0;
	var beginTime = new Date().getTime();
	var isScrolling = false;
	var intervalSendTrackingData = 30;
	var trackingURL = 'http://localhost:3000/api/posts/track';
	//array of all posts
	$scope.posts = [];
	
	$scope.init = function () {
		$scope.getPosts(currentPage);
		
		setInterval(function() {
			
			if(trackingData != []) {
				$http.post(trackingURL, trackingData).
				success(function(data) {
					console.log('tracking data was successfully posted');
				}).
				error(function(data) {
					console.log('there was an error posting the tracking data');
				});
			}
		}, 1000 * intervalSendTrackingData);
	};

	$scope.numPosts = function() {
		var num = 0;
		angular.forEach($scope.posts, function(posts) {
			if(posts.visible) {
				num++;
			}
		});
		return num;
	};
	
	//pull sources for the specified user
	$scope.getPosts = function(page) {
		console.log('getting page '+page);
		var postURL = 'http://localhost:3000/api/posts.json?page='+currentPage;
		$http.get(postURL).
		success(function(data) {
			currentPage++;
			//format time stamps nicely (ex. a few seconds ago)
			angular.forEach(data, function(post) {
				post.post.created_time = new Date(post.post.created_time).toRelativeTime();
				$scope.posts.push(post);
			});
			
			//$scope.posts.concat(data);
		}).
		error(function(data) {
			alert('there was an error getting your sources');
		});
	};
	
	$scope.fetch = function() {
		$scope.getPosts(currentPage);		
	};
	
	$scope.loadMorePosts = function() {
		$scope.getPosts(currentPage);
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
	
	$scope.scrollStop = function() {
		isScrolling = false;
		console.log('end scroll');
		beginTime = new Date().getTime();
		
	}
	
	$scope.updateData = function() {
		
		if(!isScrolling) {
			var currentTime = new Date().getTime();
			var timeDiff = currentTime - beginTime;
			
			//find which posts are visible
			$('.post').each(function(index, element) {
				if($scope.isVisible(element)) {
					
					//variable used to break out of for loop if it already exists
					var elementExists = false;
					
					for (var i = trackingData.length - 1; i > -1; i--) {
						//if element is already in array, add time to existing entry
						if (trackingData[i].id === $(element).attr('id')) {
							trackingData[i].time += timeDiff;
							elementExists = true;
							console.log("element "+$(element).attr('id')+" already exists in the database\nIt's time is now "+trackingData[i].time);
						}
					}
					
					//if element doesn't exist yet, add it to the array
					if(!elementExists) {
						var tempData = {id:$(element).attr('id'), time:timeDiff};
						trackingData.push(tempData);
						console.log("ID: "+tempData.id+", Time: "+tempData.time);
					}
				}
			});
		}
		
		isScrolling = true;
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
