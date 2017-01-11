(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		jqWindow = $(window),
		jqBody = $('.body'),
		utils = modules.Utils,
		debounce = utils.debounce;

	pageFactory.ClickableIndex = function(indexId, jqTemplateClassName, apiUrl, excludedIds, newModelCallback, clickId, afterModelRenderCallback) {

		var page = this,
			jqClickElement = $('#' + clickId);

		pageFactory.Index.call(page, indexId, jqTemplateClassName, apiUrl, excludedIds, newModelCallback);

		var setEventListeners = function() {
			jqClickElement.on("click", page.onClick);
		};

		var onClick = debounce(function() {
			page.getModelsJSON(page.onClickError);
		}, 500, true);

		var onClickError = function(errorJqXHR) {
			page.onError(errorJqXHR, page.onNextRecordsNotFound, page.onRecordNotProcessed);
		};

		var onNextRecordsNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			jqClickElement.off("click", page.onClick);
		};


		if (typeof(afterModelRenderCallback) === "function") {
			page.afterModelRender = afterModelRenderCallback;
		}

		page.clickId = clickId;
		page.setEventListeners = setEventListeners;
		page.onClick = onClick;
		page.onClickError = onClickError;
		page.onNextRecordsNotFound = onNextRecordsNotFound;

	}

})();