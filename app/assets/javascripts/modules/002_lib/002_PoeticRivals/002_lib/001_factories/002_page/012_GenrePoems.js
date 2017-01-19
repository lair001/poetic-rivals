(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.GenrePoems = function() {

		var page = this;

		page.jqTemplateClassName = 'indexable-poem-template';
		page.jqTemplateProperty = 'jqTemplate';

		pageFactory.FromPageData.call(page);
		pageFactory.JqTemplateByClassName.call(page, page.jqTemplateClassName, page.jqTemplateProperty);

		var setEventListeners = function() {
			var scrollableUserIndexPage = new pageFactory.ScrollableIndex(page.indexId, page.apiUrl, page.excludedIds, page.newModelCallback);
			scrollableUserIndexPage.setEventListeners();
		};

		var newModelCallback = function(modelJSON, indexId) {
			var indexablePoem = new viewModelFactory.IndexablePoem(modelJSON, indexId, page.jqTemplate().clone());
			return indexablePoem;
		};

		page.setEventListeners = setEventListeners;
		page.indexId = 'poems_index';
		page.apiUrl = '/genres/' + page.genreId + '/poems';
		page.newModelCallback = newModelCallback;

	}

})();