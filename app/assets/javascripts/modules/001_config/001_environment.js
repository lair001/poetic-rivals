(function() {

	// applying tabOverride to all textarea inputs

	tabOverride.set(document.getElementsByTagName('textarea'));

	// establishing modules namespace for application scripts

	if ( typeof(modules) === 'undefined' || (typeof(modules) === 'object' && !(modules instanceof Array) && !(modules === null)) ) {
		if ( typeof(modules) !== 'undefined' ) {
			console.log("Warning: modules object already exists.");
		}
		modules = {};
	} else if (modules instanceof Array) {
		throw "Fatal error: modules is an array.";
	} else {
		throw "Fatal error: modules is null.";
	}

})();