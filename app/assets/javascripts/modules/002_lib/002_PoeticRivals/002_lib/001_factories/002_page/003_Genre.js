(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page, viewModelFactory = modules.PoeticRivals.factories.viewModel, utils = modules.Utils, debounce = utils.debounce;

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
		};

		var onGetGenreJSON = function(genreJSON) {
			page.showableGenre = new viewModelFactory.ShowableGenre(genreJSON);
			page.showableGenre.render();
		};

		var setEventListeners = function() {
			$("#previous_model").on("click", page.onPreviousModelClick);
			$("#next_model").on("click", page.onNextModelClick);
		}

		var onPreviousModelClick = debounce(function() {

		}, 500, true);

		var onNextModelClick = debounce(function() {

		}, 500, true);

		page.getGenreJSON = getGenreJSON;
		page.onGetGenreJSON = onGetGenreJSON;
		page.setEventListeners = setEventListeners;
		page.onPreviousModelClick = onPreviousModelClick;
		page.onNextModelClick = onNextModelClick;

	}

})();