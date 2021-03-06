(function() {

	"use strict";

	var base = modules.PoeticRivals.base;
	var pageFactory = modules.PoeticRivals.factories.page;

	base.START = function() {

		var currentPathNameElement = document.getElementById('current_path_name');
		var currentPathName = currentPathNameElement !== null ? currentPathNameElement.dataset.currentPathName : "";

		if (currentPathName === 'aqm') {
			base.runAqmPage(new pageFactory.Aqm());
		} else if (currentPathName === 'genre') {
			base.runGenrePage(new pageFactory.Genre());
		} else if (currentPathName === 'leaderboard_users') {
			base.runLeaderboardUsersPage(new pageFactory.LeaderboardUsers());
		} else if (currentPathName === 'genre_authors') {
			base.runGenreAuthorsPage(new pageFactory.GenreAuthors());
		} else if (currentPathName === 'genre_poems') {
			base.runGenrePoemsPage(new pageFactory.GenrePoems());
		} else if (currentPathName === 'user_poems') {
			base.runUserPoemsPage(new pageFactory.UserPoems());
		} else if (currentPathName === 'user_poem_commentaries' ) {
			base.runUserPoemCommentariesPage(new pageFactory.UserPoemCommentaries());
		}

	};

})();

