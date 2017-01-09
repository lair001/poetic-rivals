(function() {

	"use strict";

	var once = modules.Utils.once,
		pageFactory = modules.PoeticRivals.factories.page,
		jqWindow = $(window),
		jqBody = $('.body');

	pageFactory.ScrollableIndex = function(indexId, jqTemplateClassName, apiUrl, excludedIds, newModelCallback) {

		var page = this;

		pageFactory.Index.call(page, indexId, jqTemplateClassName, apiUrl, excludedIds, newModelCallback);

		var setEventListeners = function() {
			if (jqWindow.height() > jqBody.height()) {
				page.getModelsJSON(page.onScrollError);
			}
			jqWindow.on("scroll", page.onScroll);
		};

		var onScroll = debounce(function() {

			if (jqWindow.scrollTop(value) > jqBody.height() - jqWindow.height() ) {
				page.getModelsJSON(page.onScrollError);
			}

		}, 500, true);

		var onScrollError = function(errorJqXHR) {
			page.onError(errorJqXHR, page.onNextRecordsNotFound, page.onRecordNotProcessed);
		};

		var onNextRecordsNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			jqWindow.off("scroll", page.onScroll);
		};

		page.setEventListeners = setEventListeners;
		page.onScroll = onScroll;
		page.onScrollError = onScrollError,
		page.onNextRecordsNotFound = onNextRecordsNotFound;

	}

})();