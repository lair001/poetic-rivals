(function() {

	"use strict";

	var base = modules.PoeticRivals.base;

	base.runGenrePage = function(genrePage) {

		// delete any params from address bar url
		window.history.pushState({}, "", window.location.pathname);
		genrePage.setEventListeners();

	};

})();