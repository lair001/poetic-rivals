(function() {

	modules.PoeticRivals.base.START = function() {

		var pageFactory = modules.PoeticRivals.factories.page;

		var aqmPage = new pageFactory.Aqm();

		aqmPage.setListeners();

	}

})();

