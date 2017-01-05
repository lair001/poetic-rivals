describe('PoeticRivals.factories.page#FromPageData', function() {

	var FromPageData = modules.PoeticRivals.factories.page.FromPageData;
	var page, dataset, key;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/page/FromPageData.html")
		page = new FromPageData();
		pageData = document.getElementById('page_data');
		dataset = pageData.dataset;
	});

	it('creates a page with all of the properties of the #page_data dataset', function() {
		for(key in dataset) {
			expect(page[key]).to.equal(dataset[key]);
		};
	});

});