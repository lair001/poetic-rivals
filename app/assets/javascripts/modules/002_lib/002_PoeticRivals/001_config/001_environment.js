// establishing namespace for PoeticRivals module

(function() {

	if (typeof(modules.PoeticRivals) === 'undefined') {
		modules.PoeticRivals = {
			factories: {},
			base: {}
		};

	} else {
		throw 'Fatal error: modules.PoeticRivals already exists.';
	}

})();