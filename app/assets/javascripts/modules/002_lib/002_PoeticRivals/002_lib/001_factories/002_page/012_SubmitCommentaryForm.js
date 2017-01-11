(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		jqWindow = $(window),
		jqBody = $('.body'),
		utils = modules.Utils,
		once = utils.once,
		debounce = utils.debounce;

	pageFactory.SubmitCommentaryForm = function(indexId, jqTemplateClassName, apiUrl, newModelCallback, formId, afterModelRenderCallback) {

		var page = this,
			jqForm = $('#' + formId);

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
					success: page.onPost,
					error: page.onError
				}
			);
		}, 5000, true);

		var onPost = function(JSON) {
			console.log(JSON);
		};

		var onError = function(jqXHR) {
			console.log(jqXHR);
			console.log(jqXHR.responseJSON);
		}

		page.indexId = indexId;
		page.jqTemplateClassName = jqTemplateClassName;
		page.apiUrl = apiUrl;
		page.newModelCallback = newModelCallback;
		page.formId = formId;
		page.afterModelRenderCallback = afterModelRenderCallback;
		page.setEventListeners = setEventListeners;
		page.jqTemplate = jqTemplate;
		page.onPost = onPost;
		page.onError = onError;

	}

})();