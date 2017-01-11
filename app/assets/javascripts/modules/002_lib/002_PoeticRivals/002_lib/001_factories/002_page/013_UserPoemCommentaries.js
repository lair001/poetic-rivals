(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		viewModelFactory = modules.PoeticRivals.factories.viewModel,
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.UserPoemCommentaries = function() {

		var page = this;

		pageFactory.FromPageData.call(page);

		var jqButtonsTemplate = once(function() {
			return $("#" + page.jqButtonsTemplateId).children().clone();
		});

		var setEventListeners = function() {
			var clickableCommentaryIndexPage = new pageFactory.ClickableIndex(page.indexId, page.jqTemplateClassName, page.indexApiUrl, page.excludedIds, page.indexPageNewModelCallback, page.clickId, page.indexPageAfterModelRender),
				submitCommentaryFormPage = new pageFactory.SubmitCommentaryForm(page.indexId, page.jqTemplateClassName, page.submitApiUrl, page.indexPageNewModelCallback, page.formId, page.indexPageAfterModelRender, clickableCommentaryIndexPage);
			clickableCommentaryIndexPage.setEventListeners();
			submitCommentaryFormPage.setEventListeners();
		}

		var indexPageAfterModelRender = function(model) {
			if (model.can_edit) {
				model.updateJqButtonsTemplate();
				model.renderButtons();
			}
		}

		var indexPageNewModelCallback = function(modelJSON, indexId, jqTemplate) {
			var indexableIndexableCommentary = new viewModelFactory.IndexableCommentary(modelJSON, indexId, jqTemplate, page.jqButtonsTemplate().clone());
			return indexableIndexableCommentary;
		}

		page.setEventListeners = setEventListeners;
		page.indexId = 'commentaries_index';
		page.jqTemplateClassName = 'indexable-commentary-template';
		page.indexApiUrl = '/users/' + page.userId + '/poems/' + page.poemId + '/commentaries';
		page.indexPageNewModelCallback = indexPageNewModelCallback;
		page.jqButtonsTemplateId = "indexable_commentary_edit_and_delete_buttons_template";
		page.clickId = "more_comments";
		page.jqButtonsTemplate = jqButtonsTemplate;
		page.indexPageAfterModelRender = indexPageAfterModelRender;
		page.formId = "new_commentary";
		page.submitApiUrl = "/commentaries";

	}

})();