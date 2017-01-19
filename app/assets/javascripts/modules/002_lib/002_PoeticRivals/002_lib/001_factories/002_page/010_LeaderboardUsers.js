(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.LeaderboardUsers = function() {

		var page = this;

		page.jqTemplateClassName = 'indexable-user-template';
		page.jqTemplateProperty = 'jqTemplate';

		pageFactory.FromPageData.call(page);
		pageFactory.JqTemplateByClassName.call(page, page.jqTemplateClassName, page.jqTemplateProperty);

		var setEventListeners = function() {
			var scrollableUserIndexPage = new pageFactory.ScrollableIndex(page.indexId, page.apiUrl, page.excludedIds, page.newModelCallback);
			scrollableUserIndexPage.setEventListeners();
		};

		var newModelCallback = function(modelJSON, indexId) {
			var indexableUser = new viewModelFactory.IndexableUser(modelJSON, indexId, page.jqTemplate().clone());
			return indexableUser;
		};

		page.setEventListeners = setEventListeners;
		page.indexId = 'users_index';
		page.apiUrl = '/leaderboard/users';
		page.newModelCallback = newModelCallback;

	}

})();