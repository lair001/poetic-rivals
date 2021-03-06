(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		jqWindow = $(window),
		jqBody = $('.body'),
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.SubmitCommentaryForm = function(indexId, apiUrl, newModelCallback, formId, afterModelRenderCallback, indexPage) {

		var page = this,
			jqForm = $('#' + formId),
			jqFormSubmitButton = $('#' + formId + ' input[type="submit"]');

		pageFactory.Index.call(page, indexId, apiUrl, newModelCallback);
		pageFactory.Error.call(page);

		var setEventListeners = function() {
			jqForm.on("submit", page.onSubmit);
			jqFormSubmitButton.removeAttr("data-disable-with");
		};

		var jqModelErrorsTemplate = once(function() {
			return $("#" + page.modelErrorsTemplateId).children().clone();
		});

		var onSubmit = function(event) {
			event.preventDefault();
			page.data = $(this).serialize();
			page.postCommentary();
		};

		var onSubmitError = function(errorJqXHR) {
			console.log(errorJqXHR);
			console.log(errorJqXHR.responseJSON);
			page.onError(errorJqXHR, page.onRecordNotFound, page.onRecordNotProcessed);
		};

		var postCommentary = debounce(function() {
			$.ajax(
				{
					url: page.apiUrl,
					method: "POST",
					data: page.data,
					dataType: "json",
					success: page.onPost,
					error: page.onSubmitError
				}
			);
		}, 5000, true);

		var onPost = function(modelJSON) {
			var model = newModelCallback(modelJSON, page.indexId);
			model.updateJqTemplate();
			model.render();
			if (page.afterModelRender) {
				page.afterModelRender(model);
			}
			page.indexPage.excludedIds += "," + model.id;
			$('.model-errors').remove();
			$('div.field_with_errors').children().unwrap();
			$('#' + page.formId + ' textarea').val("");
			// jqFormSubmitButton.prop("disabled", false);
		};

		var onRecordNotProcessed = function(error, errorJqXHR, recordNotFoundCallback, self) {
			var newJqModelErrorsElement = page.jqModelErrorsTemplate().clone();
			newJqModelErrorsElement.find(".error-messages").html(error.detail);
			newJqModelErrorsElement.prependTo('#' + page.formJumbotronId);

			$('#' + page.formId + ' label').wrap('<div class = "field_with_errors"></div>');
			$('#' + page.formId + ' textarea').wrap('<div class = "field_with_errors"></div>');
		};

		var onRecordNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			console.log("Status %s: %s", error.status, error.title);
			console.log("This should not be possible on this page.");
		};

		page.modelErrorsTemplateId = 'model_errors_template';
		page.formJumbotronId = 'commentary_form';
		page.indexId = indexId;
		page.apiUrl = apiUrl;
		page.newModelCallback = newModelCallback;
		page.formId = formId;
		if (typeof(afterModelRenderCallback) === "function") {
			page.afterModelRender = afterModelRenderCallback;
		}
		page.indexPage = indexPage;
		page.setEventListeners = setEventListeners;
		page.jqModelErrorsTemplate = jqModelErrorsTemplate;
		page.onSubmit = onSubmit;
		page.onSubmitError = onSubmitError;
		page.postCommentary = postCommentary;
		page.onPost = onPost;
		page.onRecordNotProcessed = onRecordNotProcessed;
		page.onRecordNotFound = onRecordNotFound;
	}

})();