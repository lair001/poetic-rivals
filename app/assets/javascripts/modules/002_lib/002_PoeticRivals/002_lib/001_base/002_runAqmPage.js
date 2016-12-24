(function() {

	"use strict";

	var base = modules.PoeticRivals.base;

	base.runAqmPage = function() {

		var pageFactory = modules.PoeticRivals.factories.page;
		var aqmPage = new pageFactory.Aqm();
		aqmPage.onGetQuoteClick();

	};

})();