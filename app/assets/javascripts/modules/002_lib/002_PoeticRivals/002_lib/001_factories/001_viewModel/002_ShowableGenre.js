(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.ShowableGenre = function(JSON) {

			var genre = this;

			var render = function() {
				var poemsLink = document.getElementById('poems_link');
				var newPoemsLinkHref = poemsLink.getAttribute("href").replace(/\/genres\/(\d)+/, "/genres/" + genre.id);

				var authorsLink = document.getElementById('authors_link');
				var newAuthorsLinkHref = authorsLink.getAttribute("href").replace(/\/genres\/(\d)+/, "/genres/" + genre.id);

				document.getElementById('poems_count').innerHTML = genre.poems_count;
				document.getElementById('authors_count').innerHTML = genre.authors_count;
				document.getElementById('page_title').innerHTML = genre.show_page_title;
				document.getElementById('page_tagline').innerHTML = genre.show_page_tagline;
				poemsLink.setAttribute("href", newPoemsLinkHref);
				authorsLink.setAttribute("href", newAuthorsLinkHref);

			};

			viewModelFactory.FromJSON.call(genre, JSON);

			this.render = render;

		}

})();