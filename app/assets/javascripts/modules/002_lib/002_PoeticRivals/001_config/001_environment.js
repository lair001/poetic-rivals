// establishing namespace for PoeticRivals module

(function() {

	"use strict";

	if (typeof(modules.PoeticRivals) === 'undefined') {
		modules.PoeticRivals = {
			factories: {},
			base: {}
		};

	} else {
		throw 'Fatal error: modules.PoeticRivals already exists.';
	}

})();