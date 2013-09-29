window.App = angular.module('dynamite', ['ngResource', 'infinite-scroll']);

App.run(function($rootScope) {
    /*
        Receive emitted message and broadcast it.
        Event names must be distinct or browser will blow up!
    */
    $rootScope.$on('handleEmit', function(event, args) {
        $rootScope.$broadcast('handleBroadcast', args);
    });
    
    $rootScope.$on('emitLoadData', function(event, args) {
        $rootScope.$broadcast('broadcastLoadData', args);
    });
    
    $rootScope.$on('stopScroll', function(event, args) {
        $rootScope.$broadcast('scrollStopped', args);
    });
    
    $rootScope.$on('emitLoadData', function(event, args) {
        $rootScope.$broadcast('broadcastLoadData', args);
    });
});