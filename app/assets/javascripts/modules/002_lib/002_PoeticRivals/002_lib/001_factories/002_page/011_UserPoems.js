(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.UserPoems = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		var setEventListeners = function() {
			var scrollableUserIndexPage = new pageFactory.ScrollableIndex(page.indexId, page.apiUrl, page.excludedIds, page.newModelCallback);
			scrollableUserIndexPage.setEventListeners();
		};

		var jqTemplate = once(function() {
			return $($("." + page.jqTemplateClassName)[0]).clone();
		});

		var newModelCallback = function(modelJSON, indexId) {
			var indexablePoem = new viewModelFactory.IndexablePoem(modelJSON, indexId, page.jqTemplate().clone());
			return indexablePoem;
		};

		page.setEventListeners = setEventListeners;
		page.jqTemplate = jqTemplate;
		page.indexId = 'poems_index';
		page.jqTemplateClassName = 'indexable-poem-template';
		page.apiUrl = '/users/' + page.userId + '/poems';
		page.newModelCallback = newModelCallback;

	}

})();