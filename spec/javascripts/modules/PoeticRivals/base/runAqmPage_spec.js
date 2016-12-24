describe('PoeticRivals.base#runAqmPage', function() {

	"use strict";

	var aqmGetQuoteButton, jQueryAqmGetQuoteButton, spy1, spy2, aqmPage;

	var base = modules.PoeticRivals.base;
	var pageFactory = modules.PoeticRivals.factories.page;

	beforeEach(function() {
		fixture.set('<button id="aqm_get_quote"></button>');
		aqmGetQuoteButton = document.getElementById("aqm_get_quote");
		jQueryAqmGetQuoteButton = $("#aqm_get_quote");
		aqmPage = new pageFactory.Aqm();
	});

	afterEach(function() {
		jQueryAqmGetQuoteButton.off();
	});

	it('uses the Aqm page object and jQuery to attach a click event to #aqm_get_quote', sinon.test(function() {
		spy1 = this.spy(window, '$');
		spy2 = this.spy(aqmPage, 'onGetQuoteClick');
		base.runAqmPage(aqmPage);
		expect(spy2).to.have.been.called;
		expect(spy1).to.have.been.calledWith('#aqm_get_quote');
		expect(!!$._data(aqmGetQuoteButton, "events").click).to.be.true;
	}));

});