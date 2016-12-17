(function() {

	modules.PoeticRivals.base.START = function() {

		var pageFactory = modules.PoeticRivals.factories.page;

		var currentPathNameElement = document.getElementById('current_path_name');

		var currentPathName = currentPathNameElement !== null ? currentPathNameElement.dataset.currentPathName : "";

		if (currentPathName === 'aqm') {

			var aqmPage = new pageFactory.Aqm();
			aqmPage.onGetQuoteClick();

		}

	}

})();

