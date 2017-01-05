describe('PoeticRivals.factories.page#FromPageData', function() {

	"use strict";

	var Genre = modules.PoeticRivals.factories.page.Genre, genrePage, pageData, dataset, genresCount, sortPosition, key;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/page/Genre.html");
		pageData = document.getElementById('page_data');
		dataset = pageData.dataset;
	});

	it('creates a genre page with a genres count and a sort position', function() {
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = parseInt(dataset.sortPosition, 10);
		expect(genrePage.genresCount).to.equal(genresCount);
		expect(genrePage.sortPosition).to.equal(sortPosition);
	});

	it("creates a genre page with a sort position equal to half of the genres count rounded down if #page_data's dataset does not have a valid sort position and genres count is greater than or equal to 2", function() {
		dataset.sortPosition = "";
		dataset.genresCount = "115";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = Math.floor(genresCount/2);
		expect(genrePage.sortPosition).to.equal(sortPosition);

		dataset.genresCount = "2";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = Math.floor(genresCount/2);
		expect(genrePage.sortPosition).to.equal(sortPosition);
	});

	it("creates a genre page with a sort position equal to 1 if #page_data's dataset does not have a valid sort position and genres count is less than 2", function() {
		dataset.sortPosition = "";
		dataset.genresCount = "1";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		expect(genrePage.sortPosition).to.equal(1);

		dataset.genresCount = "0";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		expect(genrePage.sortPosition).to.equal(1);
	});

});