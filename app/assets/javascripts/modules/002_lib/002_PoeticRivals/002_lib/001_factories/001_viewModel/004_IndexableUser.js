(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.IndexableUser = function(JSON, indexId, jqTemplate) {

			var user = this;

			viewModelFactory.Indexable.call(user, JSON, indexId, jqTemplate);

			var updateJqTemplate = function() {
				var usernameLink = user.jqTemplate.find('.username'),
					newUsernameLinkHref = usernameLink.attr("href").replace(/\/users\/(\d)+/, "/users/" + user.id);

				usernameLink.html(user.username);
				usernameLink.attr("href", newUsernameLinkHref);

				user.jqTemplate.find('.role').html(user.rendered_role);
				user.jqTemplate.find('.created-at-date').html(user.created_at_date);
				user.jqTemplate.find('.created-at-time').html(user.created_at_time);
				user.jqTemplate.find('.score').html(user.score);
				user.jqTemplate.find('.rounded-score-per-poem').html(user.rounded_score_per_poem);
			};

			user.updateJqTemplate = updateJqTemplate;

		}

})();