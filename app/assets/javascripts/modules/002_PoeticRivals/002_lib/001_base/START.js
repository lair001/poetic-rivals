(function() {

	modules.PoeticRivals.base.START = function() {

		var pageFactory = modules.PoeticRivals.factories.page;

		var currentPathName = document.getElementById('current_path_name').dataset.currentPathName;

		if (currentPathName === 'aqm') {

			var aqmPage = new pageFactory.Aqm();
			aqmPage.onGetQuoteClick();

		}

	}

})();

