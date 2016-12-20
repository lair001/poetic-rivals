describe('once', function() {

	var once = modules.Utils.once;

	var spy, fn;

	beforeEach(function() {
		spy = sinon.spy(function() { return 42; } );
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