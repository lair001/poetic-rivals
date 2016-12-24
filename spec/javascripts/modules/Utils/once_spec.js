describe('Utils#once', function() {

	"use strict";

	var once = modules.Utils.once;

	var i, spy, fn;

	beforeEach(function() {
		i = 41;
		spy = sinon.spy(function() {
			return ++i;
		});
		fn = once(function() {
			return spy();
		});
	});

	it('executes a function only once, remembering its return value', function() {
		expect(fn()).to.equal(42);
		expect(fn()).to.equal(42);
		expect(spy).to.have.been.calledOnce;
	});

});