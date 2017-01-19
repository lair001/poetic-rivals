(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page,
		utils = modules.Utils,
		once = utils.once;

	pageFactory.JqTemplateByClassName = function(jqTemplateClassName, jqTemplateProperty) {

		var page = this;

		if (typeof(jqTemplateProperty) !== 'string') {
			jqTemplateProperty = 'jqTemplate';
		}

		page[jqTemplateProperty] = once(function() {
			return $($("." + jqTemplateClassName)[0]).clone();
		});

	}

})();