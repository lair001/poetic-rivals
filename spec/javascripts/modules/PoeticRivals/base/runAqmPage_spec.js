describe('PoeticRivals.base#runAqmPage', function() {

	"use strict";

	var aqmGetQuoteButton, jQueryAqmGetQuoteButton, spy1;

	var base = modules.PoeticRivals.base;
	var pageFactory = modules.PoeticRivals.factories.page;

	beforeEach(function() {
		fixture.set('<button id="aqm_get_quote"></button>');
		aqmGetQuoteButton = document.getElementById("aqm_get_quote");
		jQueryAqmGetQuoteButton = $("#aqm_get_quote");
	});

	afterEach(function() {
		jQueryAqmGetQuoteButton.off();
	});

	it('creates an Aqm page object', function() {
		spy1 = sinon.spy(pageFactory, "Aqm");
		base.runAqmPage();
		expect(spy1).to.have.been.calledWithNew;
		spy1.restore();
	});

	it('uses the Aqm page object and jQuery to attach a click event to #aqm_get_quote', function() {
		spy1 = sinon.spy(window, '$');
		base.runAqmPage();
		expect(spy1).to.have.been.calledWith('#aqm_get_quote');
		expect(!!$._data(aqmGetQuoteButton, "events").click).to.be.true;
		spy1.restore();
	});

});