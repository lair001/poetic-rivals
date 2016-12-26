(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.ShowableGenre = function(JSON) {

			var genre = this;

			var render = function() {

			};

			viewModelFactory.FromJSON.call(genre, JSON);

			this.render = render;

		}

})();