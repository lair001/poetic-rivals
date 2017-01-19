(function() {

	"use strict";

	var utils = modules.Utils,
		once = utils.once,
		pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.Index = function(indexId, apiUrl, excludedIds, newModelCallback) {

		var page = this;

		pageFactory.Error.call(page);

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
				var model = newModelCallback(modelJSON, page.indexId);
				model.updateJqTemplate();
				model.render();
				if (page.afterModelRender) {
					page.afterModelRender(model);
				}
				page.excludedIds += "," + model.id;
			});
		};

		var onRecordNotProcessed = function(error, errorJqXHR, recordNotFoundCallback, self) {
			console.log("Status %s: %s", error.status, error.title);
			console.log("This should not be possible on this page.");
		}

		page.indexId = indexId;
		page.apiUrl = apiUrl;
		page.excludedIds = excludedIds;
		page.newModelCallback = newModelCallback;
		page.getModelsJSON = getModelsJSON;
		page.onGetModelsJSON = onGetModelsJSON;
		page.onRecordNotProcessed = onRecordNotProcessed;

	}

})();