(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.FromPageData = function() {

			var pageData = document.getElementById('page_data');
			var page = this, key;

			if (pageData !== null) {

				var dataset = pageData.dataset;

				for (key in dataset) {
					page[key] = dataset[key];
				}

			}

		}

})();