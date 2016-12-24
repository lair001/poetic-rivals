(function() {

	"use strict";

	modules.Utils.swallow = function (thrower) {
	    try {
	        thrower();
	    } catch (e) { }
	};

})();