(function() {

	var base = modules.PoeticRivals.base;

	base.START = function() {

		var currentPathNameElement = document.getElementById('current_path_name');
		var currentPathName = currentPathNameElement !== null ? currentPathNameElement.dataset.currentPathName : "";

		if (currentPathName === 'aqm') {
			base.runAqmPage();
		}

	};

})();

