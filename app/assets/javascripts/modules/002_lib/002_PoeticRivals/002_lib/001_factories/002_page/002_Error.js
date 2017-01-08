(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.Error = function() {

		var page = this;

		var onError = function(errorJqXHR, recordNotFoundCallback, recordNotProcessedCallback) {

			var JSONerrors = errorJqXHR.responseJSON.errors, body, head;
			console.log(JSONerrors);

			for (var i = 0; i < JSONerrors.length; i++) {
				if (JSONerrors[i].status === 403) {
					body = $("body");
					head = $("head");
					body.children().remove();
					head.children().remove();
					body.off();
					head.off();
					$("html").off();
					$(window).off();
					body.html("<h1>" + JSONerrors[i].title + "</h1>");
					i = JSONerrors.length;
				} else if (JSONerrors[i].status === 404) {
					recordNotFoundCallback(JSONerrors[i], arguments);
				} else if (JSONerrors[i].status === 422) {
					recordNotProcessedCallback(JSONerrors[i], arguments);
				}
			}
		}

		page.onError = onError;

	}

})();