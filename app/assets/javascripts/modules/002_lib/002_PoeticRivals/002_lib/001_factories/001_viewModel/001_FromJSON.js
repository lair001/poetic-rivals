(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.FromJSON = function(JSON) {

			var vm = this, key;

			for (key in JSON) {
				vm[key] = JSON[key];
			}

		}

})();