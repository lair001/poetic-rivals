describe('PoeticRivals.base#START', function() {

	"use strict";

	var jQCurrentPathName;
	var base = modules.PoeticRivals.base;
	var pageFactory = modules.PoeticRivals.factories.page;

	beforeEach(function() {
		fixture.set('<div id="current_path_name"></div>');
		jQCurrentPathName = $("#current_path_name");
	});

	it('creates and runs a Aqm page if the current path name is aqm', sinon.test(function() {
		jQCurrentPathName.attr("data-current-path-name", "aqm");
		var spy1 = this.spy(base, "runAqmPage");
		var spy2 = this.spy(pageFactory, "Aqm");
		base.START();
		expect(spy2).to.have.been.calledWithNew;
		expect(spy1).to.have.been.calledWithMatch(sinon.match.instanceOf(pageFactory.Aqm));
	}));

	it('creates and runs a Genre page if the current path name is genre', sinon.test(function() {
		jQCurrentPathName.attr("data-current-path-name", "genre");
		var spy1 = this.spy(base, "runGenrePage");
		var spy2 = this.spy(pageFactory, "Genre");
		base.START();
		expect(spy2).to.have.been.calledWithNew;
		expect(spy1).to.have.been.calledWithMatch(sinon.match.instanceOf(pageFactory.Genre));
	}));

});