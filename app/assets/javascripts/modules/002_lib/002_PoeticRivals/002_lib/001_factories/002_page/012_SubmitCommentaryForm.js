(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		jqWindow = $(window),
		jqBody = $('.body'),
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.SubmitCommentaryForm = function(indexId, jqTemplateClassName, apiUrl, newModelCallback, formId, afterModelRenderCallback, indexPage) {

		var page = this,
			jqForm = $('#' + formId),
			jqFormSubmitButton = $('#' + formId + ' input[type="submit"]');

		pageFactory.Index.call(page, indexId, jqTemplateClassName, apiUrl, newModelCallback);
		pageFactory.Error.call(page);

		var setEventListeners = function() {
			jqForm.on("submit", page.onSubmit);
			jqFormSubmitButton.removeAttr("data-disable-with");
		};

		var jqTemplate = once(function() {
			return $($("." + page.jqTemplateClassName)[0]).clone();
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
			var model = newModelCallback(modelJSON, page.indexId, page.jqTemplate().clone());
			model.updateJqTemplate();
			model.render();
			if (page.afterModelRender) {
				page.afterModelRender(model);
			}
			page.indexPage.excludedIds += "," + model.id;
			// jqFormSubmitButton.prop("disabled", false);
		};

		var onRecordNotProcessed = function(error, errorJqXHR, recordNotFoundCallback, self) {
			$('#' + page.formId + ' label').wrap('<div class = "field_with_errors"></div>');
			$('#' + page.formId + ' textarea').wrap('<div class = "field_with_errors"></div>');
		};

		var onRecordNotFound = function(error, errorJqXHR, self, recordNotProcessedCallback) {
			console.log("Status %s: %s", error.status, error.title);
			console.log("This should not be possible on this page.");
		};

		page.indexId = indexId;
		page.jqTemplateClassName = jqTemplateClassName;
		page.apiUrl = apiUrl;
		page.newModelCallback = newModelCallback;
		page.formId = formId;
		if (typeof(afterModelRenderCallback) === "function") {
			page.afterModelRender = afterModelRenderCallback;
		}
		page.indexPage = indexPage;
		page.setEventListeners = setEventListeners;
		page.jqTemplate = jqTemplate;
		page.onSubmit = onSubmit;
		page.onSubmitError = onSubmitError;
		page.postCommentary = postCommentary;
		page.onPost = onPost;
		page.onRecordNotProcessed = onRecordNotProcessed;
		page.onRecordNotFound = onRecordNotFound;
	}

})();