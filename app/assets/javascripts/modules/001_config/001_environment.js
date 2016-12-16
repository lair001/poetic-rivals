(function() {

	// applying tabOverride to all textarea inputs

	tabOverride.set(document.getElementsByTagName('textarea'));

	//attempting to fix a bug with Bootstrap dropdowns where they stop working after the user follows a link in the dropdowns

	$(document).ready(function() {
	    $(".dropdown-toggle").dropdown();
	});

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