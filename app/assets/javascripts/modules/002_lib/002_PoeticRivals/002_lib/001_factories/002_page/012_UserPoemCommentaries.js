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
			var clickableCommentaryIndexPage = new pageFactory.ClickableIndex(page.indexId, page.jqTemplateClassName, page.apiUrl, page.excludedIds, page.indexPageNewModelCallback, page.clickId, page.indexPageAfterModelRender);
			clickableCommentaryIndexPage.setEventListeners();
		}

		var indexPageAfterModelRender = function(model) {
			if (model.can_edit) {
				model.renderButtons();
			}
		}

		var indexPageNewModelCallback = function(modelJSON, indexId, jqTemplate) {
			var indexableIndexableCommentary = new viewModelFactory.IndexableCommentary(modelJSON, indexId, jqTemplate, page.jqButtonsTemplate().clone());
			return indexableIndexableCommentary;
		}

		page.setEventListeners = setEventListeners;
		page.indexId = 'poems_index';
		page.jqTemplateClassName = 'indexable-poem-template';
		page.apiUrl = '/users/' + page.userId + '/poems';
		page.indexPageNewModelCallback = indexPageNewModelCallback;
		page.jqButtonsTemplateId = "indexable_commentary_edit_and_delete_buttons_template";
		page.clickId = "more_comments";
		page.jqButtonsTemplate = jqButtonsTemplate;
		page.indexPageAfterModelRenderCallback = indexPageAfterModelRender;

	}

})();