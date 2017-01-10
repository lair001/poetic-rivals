(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		debounce = utils.debounce;

	pageFactory.GenreAuthors = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		var setEventListeners = function() {
			var scrollableUserIndexPage = new pageFactory.ScrollableIndex(page.indexId, page.jqTemplateClassName, page.apiUrl, page.excludedIds, page.newModelCallback);
			scrollableUserIndexPage.setEventListeners();
		}

		var newModelCallback = function(modelJSON, indexId, jqTemplate) {
			var indexablePoem = new viewModelFactory.IndexablePoem(modelJSON, indexId, jqTemplate);
			return indexablePoem;
		}

		page.setEventListeners = setEventListeners;
		page.indexId = 'poems_index';
		page.jqTemplateClassName = 'indexable-poem-template';
		page.apiUrl = '/genres/' + page.genreId + '/poems';
		page.newModelCallback = newModelCallback;

	}

})();