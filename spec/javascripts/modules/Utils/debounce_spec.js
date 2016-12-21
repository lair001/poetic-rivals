describe('Utils#debounce', function() {

	var debounce = modules.Utils.debounce;
	var clock, spy, fn;

	beforeEach(function() {
		clock = sinon.useFakeTimers();
		spy = sinon.spy();
		fn = debounce(function() {
			spy();
		}, 100);
	});

	afterEach(function() {
		clock.restore();
	});

	it('executes the specified function after the specified wait time', function() {
		fn();
		clock.tick(99);
		expect(spy).to.not.have.been.called;
		clock.tick(1);
		expect(spy).to.have.been.calledOnce;
	});

	it('does not execute the function if pinged during the wait time', function() {
		fn();
		clock.tick(50);
		fn();
		clock.tick(50);
		expect(spy).to.not.have.been.called;
		clock.tick(49);
		expect(spy).to.not.have.been.called;
		clock.tick(1);
		expect(spy).to.have.been.calledOnce;
		fn();
		expect(spy).to.have.been.calledOnce;
		clock.tick(99);
		expect(spy).to.have.been.calledOnce;
		clock.tick(1);
		expect(spy).to.have.been.calledTwice;
	});

	it('executes function on the leading edge of the wait interval if the immediate flag is set', function() {
		fn = debounce(function() {
			spy();
		}, 100, true);
		fn();
		expect(spy).to.have.been.calledOnce;
		clock.tick(50);
		fn();
		clock.tick(100);
		expect(spy).to.have.been.calledOnce;
		fn();
		expect(spy).to.have.been.calledTwice;
	});

});