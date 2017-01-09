(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		debounce = utils.debounce;

	pageFactory.LeaderboardUsers = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		var setEventListeners = function() {
			var scrollableUserIndexPage = new pageFactory.ScrollableIndex(page.indexId, page.jqTemplateClassName, page.apiUrl, page.excludedIds, page.newModelCallback);
			scrollableUserIndexPage.setEventListeners();
		}

		var newModelCallback = function(modelJSON, indexId, jqTemplate) {
			var indexableUser = new viewModelFactory.IndexableUser(modelJSON, indexId, jqTemplate);
			return indexableUser;
		}

		page.setEventListeners = setEventListeners;
		page.indexId = 'users_index';
		page.jqTemplateClassName = 'indexable-user-template';
		page.apiUrl = '/leaderboard/users';
		page.newModelCallback = newModelCallback;

	}

})();