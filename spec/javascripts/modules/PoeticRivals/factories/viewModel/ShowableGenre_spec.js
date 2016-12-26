describe('PoeticRivals.factories.viewModel#ShowableGenre', function() {

	var ShowableGenre = modules.PoeticRivals.factories.viewModel.ShowableGenre;

	it('creates a showable genre with all of the properties of the JSON source', function() {
		var JSON = { "foo": "alpha", "bar": "beta", "baz": "gamma" };
		var genre = new ShowableGenre(JSON);
		for(key in JSON) {
			expect(genre[key]).to.equal(JSON[key]);
		};
	});

});