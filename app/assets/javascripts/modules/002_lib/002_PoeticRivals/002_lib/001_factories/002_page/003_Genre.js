(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.Genre = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		page.genresCount = parseInt(page.genresCount, 10);
		page.sortPosition = parseInt(page.sortPosition, 10);

		if (isNaN(page.sortPosition)) {
			page.sortPosition = Math.max(Math.floor(page.genresCount/2), 1);
		}

	}

})();