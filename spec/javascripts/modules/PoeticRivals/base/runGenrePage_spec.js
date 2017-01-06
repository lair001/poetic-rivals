describe('PoeticRivals.base#runGenrePage', function() {

	"use strict";

	var runGenrePage = modules.PoeticRivals.base.runGenrePage, GenrePage = modules.PoeticRivals.factories.page.Genre, genrePage, spy1;

	beforeEach(function() {
		genrePage = new GenrePage();
	});

	it('executes the #setEventListeners method of the genrePage passed as an argument', sinon.test(function() {
		spy1 = this.spy(genrePage, "setEventListeners");
		runGenrePage(genrePage);
		expect(spy1).to.have.been.called;
	}));


});