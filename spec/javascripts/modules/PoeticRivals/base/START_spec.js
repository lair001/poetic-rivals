describe('PoeticRivals.base#START', function() {

	var jQCurrentPathName;
	var base = modules.PoeticRivals.base;

	beforeEach(function() {
		fixture.set('<div id="current_path_name"></div>');
		jQCurrentPathName = $("#current_path_name");
	});

	it('runs the Aqm page if the current path name is aqm', function() {
		jQCurrentPathName.attr("data-current-path-name", "aqm")
		var spy1 = sinon.spy(base, "runAqmPage");
		base.START();
		expect(spy1).to.have.been.called;
		spy1.restore();
	});

});