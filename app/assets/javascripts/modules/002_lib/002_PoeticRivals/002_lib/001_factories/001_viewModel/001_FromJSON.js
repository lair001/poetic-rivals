(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.FromJSON = function(JSON) {

			var key
			var vm = this;

			for (key in JSON) {
				vm[key] = JSON[key];
			}

		}

})();