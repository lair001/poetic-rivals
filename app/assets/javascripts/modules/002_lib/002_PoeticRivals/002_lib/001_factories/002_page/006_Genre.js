(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page, viewModelFactory = modules.PoeticRivals.factories.viewModel, utils = modules.Utils, debounce = utils.debounce;

	pageFactory.Genre = function() {

		var page = this;

		pageFactory.FromPageData.call(page);
		pageFactory.Error.call(page);

		page.genresCount = parseInt(page.genresCount, 10);
		page.sortPosition = parseInt(page.sortPosition, 10);

		if (isNaN(page.sortPosition)) {
			page.sortPosition = Math.max(Math.floor(page.genresCount/2), 1);
		}

		var getGenreJSON = function(errorCallback) {
			$.ajax(
				{
					url: "/genres/" + page.sortPosition,
					method: "GET",
					dataType: "json",
					success: page.onGetGenreJSON,
					error: errorCallback
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

		var onRecordNotProcessed = function(error, errorJqXHR, recordNotFoundCallback, self) {
			console.log("Status %s: %s", error.status, error.title);
			console.log("This should not be possible on this page.");
		}

		var onPreviousRecordNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			if (page.sortPosition >= 2) {
				page.sortPosition--;
				page.genresCount = page.sortPosition;
				page.getGenreJSON(page.onPreviousModelClickError);
			}
		}

		var onPreviousModelClickError = function(errorJqXHR) {
			page.onError(errorJqXHR, page.onPreviousRecordNotFound, page.onRecordNotProcessed);
		}

		var onNextModelClick = debounce(function() {

			if (page.genresCount >= 2) {

				page.sortPosition++;
				page.getGenreJSON(page.onNextModelClickError);

			}

		}, 500, true);

		var onNextRecordNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			if (page.sortPosition >= 2) {
				page.sortPosition = 1;
				page.getGenreJSON(page.onNextModelClickError);
			}
		}

		var onNextModelClickError = function(errorJqXHR) {
			page.onError(errorJqXHR, page.onNextRecordNotFound, page.onRecordNotProcessed);
		}

		page.getGenreJSON = getGenreJSON;
		page.onGetGenreJSON = onGetGenreJSON;
		page.setEventListeners = setEventListeners;
		page.onRecordNotProcessed = onRecordNotProcessed;
		page.onPreviousRecordNotFound = onPreviousRecordNotFound;
		page.onPreviousModelClick = onPreviousModelClick;
		page.onPreviousModelClickError = onPreviousModelClickError;
		page.onNextModelClick = onNextModelClick;
		page.onNextRecordNotFound = onNextRecordNotFound;
		page.onNextModelClickError = onNextModelClickError;

	}

})();