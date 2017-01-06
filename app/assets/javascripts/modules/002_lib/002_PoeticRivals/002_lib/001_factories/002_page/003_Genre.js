(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page, viewModelFactory = modules.PoeticRivals.factories.viewModel;

	pageFactory.Genre = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		page.genresCount = parseInt(page.genresCount, 10);
		page.sortPosition = parseInt(page.sortPosition, 10);

		if (isNaN(page.sortPosition)) {
			page.sortPosition = Math.max(Math.floor(page.genresCount/2), 1);
		}

		var getGenreJSON = function(onError) {
			$.ajax(
				{
					url: "/genres/" + page.sortPosition,
					method: "GET",
					dataType: "json",
					success: page.onGetGenreJSON,
					error: onError
				}
			);
		}

		var onGetGenreJSON = function(genreJSON) {
			page.showableGenre = new viewModelFactory.ShowableGenre(genreJSON);
			page.showableGenre.render();
		}

		page.getGenreJSON = getGenreJSON;
		page.onGetGenreJSON = onGetGenreJSON;

	}

})();