describe('PoeticRivals.factories.viewModel#ShowableGenre', function() {

	"use strict";

	var ShowableGenre = modules.PoeticRivals.factories.viewModel.ShowableGenre, key;

	it('creates a showable genre with all of the properties of the JSON source', function() {
		var JSON = { "foo": "alpha", "bar": "beta", "baz": "gamma" };
		var genre = new ShowableGenre(JSON);
		for(key in JSON) {
			expect(genre[key]).to.equal(JSON[key]);
		};
	});

});