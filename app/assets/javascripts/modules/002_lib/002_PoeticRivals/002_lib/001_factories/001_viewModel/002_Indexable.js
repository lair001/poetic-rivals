(function() {

	"use strict";

	var viewModelFactory = modules.PoeticRivals.factories.viewModel;

	viewModelFactory.Indexable = function(JSON, indexId, jqTemplate) {

			var vm = this;

			var render = function() {
				vm.jqTemplate.appendTo('#' + vm.indexId);
			};

			viewModelFactory.FromJSON.call(vm, JSON);

			vm.jqTemplate = jqTemplate;
			vm.indexId = indexId;
			vm.render = render;

		}

})();