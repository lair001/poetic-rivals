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
			window.history.pushState({}, "", window.location.pathname.replace(/\/genres\/(\d)+/, "/genres/" + page.showableGenre.id))
			if (page.sortPosition > page.genresCount) {
				page.genresCount = page.sortPosition;
			}
		};

		var setEventListeners = function() {
			$("#previous_model").on("click", page.onPreviousModelClick);
			$("#next_model").on("click", page.onNextModelClick);
		}

		var onPreviousModelClick = debounce(function() {

			if (page.genresCount >= 2) {

				if (page.sortPosition === 1) {
					page.sortPosition = page.genresCount;
				} else {
					page.sortPosition--;
				}

				page.getGenreJSON(page.onPreviousModelClickError);

			}

		}, 500, true);

		var onPreviousModelClickError = function(errorJSON) {

			console.log(errorJSON);
			var recordNotFound = false;
			errorJSON.responseJSON.errors.forEach(function(error) {
				if (error.status === 404) {
					recordNotFound = true;
				}
			});

			if (recordNotFound && page.sortPosition >= 2) {
				page.sortPosition--;
				page.genresCount = page.sortPosition;
				page.getGenreJSON(page.onPreviousModelClickError);
			}

		}

		var onNextModelClick = debounce(function() {

			if (page.genresCount >= 2) {

				page.sortPosition++;
				page.getGenreJSON(page.onNextModelClickError);

			}

		}, 500, true);

		var onNextModelClickError = function(errorJSON) {
			console.log(errorJSON);
			var recordNotFound = false;
			errorJSON.responseJSON.errors.forEach(function(error) {
				if (error.status === 404) {
					recordNotFound = true;
				}
			});

			if (recordNotFound && page.sortPosition >= 2) {
				page.sortPosition = 1;
				page.getGenreJSON(page.onNextModelClickError);
			}
		}

		page.getGenreJSON = getGenreJSON;
		page.onGetGenreJSON = onGetGenreJSON;
		page.setEventListeners = setEventListeners;
		page.onPreviousModelClick = onPreviousModelClick;
		page.onPreviousModelClickError = onPreviousModelClickError;
		page.onNextModelClick = onNextModelClick;
		page.onNextModelClickError = onNextModelClickError;

	}

})();