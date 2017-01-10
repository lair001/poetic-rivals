(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.IndexableCommentary = function(JSON, indexId, jqTemplate) {

			var vm = this;

			viewModelFactory.Indexable.call(vm, JSON, indexId, jqTemplate, jqButtonsTemplate);

			var updateJqTemplate = function() {
				var commentatorUsernameLink = vm.jqTemplate.find('.commentator-username'),
					newCommentatorUsernameLinkHref = commentatorUsernameLink.attr("href").replace(/\/poems\/(\d)+/, "/userss/" + vm.commentator.id);

				commentatorUsernameLink.html(vm.commentator.username);
				commentatorUsernameLink.attr("href", newCommentatorUsernameLinkHref);

				vm.jqTemplate.find('.commentator-role').html(vm.commentator.rendered_role)
				vm.jqTemplate.find('.created-at-date').html(vm.created_at_date);
				vm.jqTemplate.find('.created-at-time').html(vm.created_at_time);
				vm.jqTemplate.find('.updated-at-date').html(vm.updated_at_date);
				vm.jqTemplate.find('.updated-at-time').html(vm.updated_at_time);
				vm.jqTemplate.find('.comment').html(vm.rendered_comment);
			};

			var updatejqButtonsTemplate = function() {
				var editButtonForm = vm.jqButtonsTemplate.find('[method]="get"'),
					deleteButtonForm = vm.jqButtonsTemplate.find('[method]="post"'),
					newEditButtonFormAction = editButtonForm.attr("action").replace(/\/commentaries\/(\d)+/, "/commentaries/" + vm.id),
					newDeleteButtonFormAction = deleteButtonForm.attr("action").replace(/\/commentaries\/(\d)+/, "/commentaries/" + vm.id);

				editButtonForm.attr("action", newEditButtonFormAction);
				deleteButtonForm.attr("action", newDeleteButtonFormAction);
			}

			var renderButtons = function() {
				vm.jqButtonsTemplate.appendTo('#' + vm.indexId);
			};

			vm.updateJqTemplate = updateJqTemplate,
			vm.updateJqButtonsTemplate = updatejqButtonsTemplate,
			vm.renderButtons = renderButtons;



		}

})();