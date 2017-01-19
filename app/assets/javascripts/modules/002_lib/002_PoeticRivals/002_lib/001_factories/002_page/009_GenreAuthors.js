(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.GenreAuthors = function() {

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
			var indexableUser = new viewModelFactory.IndexableUser(modelJSON, indexId, page.jqTemplate().clone());
			return indexableUser;
		};

		page.setEventListeners = setEventListeners;
		page.jqTemplate = jqTemplate;
		page.indexId = 'users_index';
		page.jqTemplateClassName = 'indexable-user-template';
		page.apiUrl = '/genres/' + page.genreId + '/authors';
		page.newModelCallback = newModelCallback;

	}

})();