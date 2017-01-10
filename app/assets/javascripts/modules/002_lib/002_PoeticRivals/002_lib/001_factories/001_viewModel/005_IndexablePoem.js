(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.IndexablePoem = function(JSON, indexId, jqTemplate) {

			var poem = this;

			viewModelFactory.Indexable.call(poem, JSON, indexId, jqTemplate);

			var updateJqTemplate = function() {
				var titleLink = poem.jqTemplate.find('.title'),
					newTitleLinkHref = titleLink.attr("href").replace(/\/poems\/(\d)+/, "/poems/" + poem.id);

				titleLink.html(poem.title);
				titleLink.attr("href", newTitleLinkHref);

				poem.jqTemplate.find('.created-at-date').html(poem.created_at_date);
				poem.jqTemplate.find('.created-at-time').html(poem.created_at_time);
				poem.jqTemplate.find('.updated-at-date').html(poem.updated_at_date);
				poem.jqTemplate.find('.updated-at-time').html(poem.updated_at_time);
				poem.jqTemplate.find('.genres-list').html(poem.genres_list);
			};

			poem.updateJqTemplate = updateJqTemplate;

		}

})();