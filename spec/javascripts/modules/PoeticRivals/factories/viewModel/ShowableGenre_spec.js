describe('PoeticRivals.factories.viewModel#ShowableGenre', function() {

	"use strict";

	var ShowableGenre = modules.PoeticRivals.factories.viewModel.ShowableGenre, key, JSON, genre;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/viewModel/ShowableGenre.html");
	});

	it('creates a showable genre with all of the properties of the JSON source', function() {
		JSON = { "foo": "alpha", "bar": "beta", "baz": "gamma" };
		genre = new ShowableGenre(JSON);
		for(key in JSON) {
			expect(genre[key]).to.equal(JSON[key]);
		};
	});

	describe('#render', function() {
		it('renders the Showable Genre on the page', function() {
			JSON = {
				"id": 36,
				"poems_count": 10,
				"authors_count": 9,
				"show_page_title": "Gab",
				"show_page_tagline": "Mostly Harmless"
			};
			genre = new ShowableGenre(JSON);
			genre.render();
			expect($("#poems_count")).to.contain.$html(JSON.poems_count);
			expect($("#authors_count")).to.contain.$html(JSON.authors_count);
			expect($("#page_title")).to.contain.$html(JSON.show_page_title);
			expect($("#page_tagline")).to.contain.$html(JSON.show_page_tagline);
			expect($("#poems_link")).to.have.$attr("href", "/genres/" + JSON.id + "/poems");
			expect($("#authors_link")).to.have.$attr("href", "/genres/" + JSON.id + "/authors");
			expect($("#edit_link")).to.have.$attr("action", "/admin/genres/" + JSON.id + "/edit");
		});
	});

});