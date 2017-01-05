describe('PoeticRivals.factories.viewModel#FromJSON', function() {

	"use strict";

	var FromJSON = modules.PoeticRivals.factories.viewModel.FromJSON, key;

	it('creates a view model with all of the properties of the JSON source', function() {
		var JSON = { "foo": "alpha", "bar": "beta", "baz": "gamma" };
		var vm = new FromJSON(JSON);
		for(key in JSON) {
			expect(vm[key]).to.equal(JSON[key]);
		};
	});

});