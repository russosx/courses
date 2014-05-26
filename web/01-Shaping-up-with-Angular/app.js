
(function() {
	
	var app = angular.module('gemStore', ['store-products']);
	
	app.controller('StoreController', ['$http', '$log', function($http, $log) {
		var store = this;
		store.products = [];
		$http.get('gems.json', {apiKey: "apiKey"}).success(function(data) {
			store.gems = data;
		});
	}]);

	app.controller('GalleryController', function() {
	    this.current = 0;
	    this.setCurrent = function(newCurrent) {
	    	this.current = newCurrent || 0;
	    }
	});

	app.controller('ReviewController', function() {
		this.review = {};
		this.addReview = function(product) {
			product.reviews.push(this.review);
			this.review = {};
		}
	});

	app.directive('reviewTitle', function() {
		return {
			restrict: 'E',
			templateUrl: 'review-title.html'
		}
	});

	app.directive('reviewTitle', function() {
		return {
			restrict: 'A',
			templateUrl: 'review-title.html'
		}
	});

	app.directive('productPanels', function() {
		return {
			restrict: 'E',
			templateUrl: 'product-panels.html',
			controller: function() {
				this.tab = 1;
				this.selectTab = function(setTab) {
					this.tab = setTab;
				}
				this.isSelected = function(checkTab) {
					return this.tab === checkTab;
				}
			},
			controllerAs: 'panels'
		};
	});


})();
