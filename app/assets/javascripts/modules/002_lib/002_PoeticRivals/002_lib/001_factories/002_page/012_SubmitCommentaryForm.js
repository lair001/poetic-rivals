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

		var setEventListeners = function() {
			jqForm.on("submit", page.onSubmit);
		};

		var jqTemplate = once(function() {
			return $($("." + page.jqTemplateClassName)[0]).clone();
		});

		var onSubmit = debounce(function(event) {
			event.preventDefault();
			var data = $(this).serialize();
			$.ajax(
				{
					url: page.apiUrl,
					method: "POST",
					data: data,
					dataType: "json",
					success: page.onPost,
					error: page.onError
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
			jqFormSubmitButton.prop("disabled", false);
		};

		var onError = function(jqXHR) {
			console.log(jqXHR);
			console.log(jqXHR.responseJSON);
			jqFormSubmitButton.prop("disabled", false);
		}

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
		page.onPost = onPost;
		page.onError = onError;

	}

})();