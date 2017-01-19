(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		utils = modules.Utils,
		once = utils.once;

	pageFactory.JqTemplateById = function(jqTemplateId, jqTemplateProperty) {

		var page = this;

		if (typeof(jqTemplateProperty) !== 'string') {
			jqTemplateProperty = 'jqButtonsTemplate';
		}

		page[jqTemplateProperty] = once(function() {
			return $("#" + jqTemplateId).children().clone();
		});

	}

})();