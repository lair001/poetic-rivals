(function() {

	"use strict";

	var utils = modules.Utils,
		once = utils.once,
		pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.Index = function(indexId, jqTemplateClassName, apiUrl, excludedIds, newModelCallback) {

		var page = this;

		pageFactory.Error.call(page);

		var jqTemplate = once(function() {
			return $($("." + page.jqTemplateClassName)[0]).clone();
		});

		var getModelsJSON = function(errorCallback) {
			$.ajax(
				{
					url: page.apiUrl + "?excluded_ids=" + page.excludedIds,
					method: "GET",
					dataType: "json",
					success: page.onGetModelsJSON,
					error: errorCallback
				}
			);
		};

		var onGetModelsJSON = function(modelsJSON) {
			modelsJSON.forEach(function(modelJSON) {
				var model = newModelCallback(modelJSON, page.indexId, page.jqTemplate.clone());
				model.updateJqTemplate();
				model.render();
				page.excludedIds += "," + model.id;
			});
		};

		var onRecordNotProcessed = function(error, errorJqXHR, recordNotFoundCallback, self) {
			console.log("Status %s: %s", error.status, error.title);
			console.log("This should not be possible on this page.");
		}

		page.indexId = indexId;
		page.jqTemplateClassName = jqTemplateClassName;
		page.apiUrl = apiUrl;
		page.excludedIds = excludedIds;
		page.jqTemplate = jqTemplate;
		page.newModelCallback = newModelCallback;
		page.getModelsJSON = getModelsJSON;
		page.onGetModelsJSON = onGetModelsJSON;
		page.onRecordNotProcessed = onRecordNotProcessed;

	}

})();