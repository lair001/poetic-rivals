
describe('sinon', function() {

	describe('spies', function() {

		function once(fn, context) { 
			var result;

			return function() { 
				if(!fn.called) {
					result = fn.apply(context || this, arguments);
					fn.called = true;
				}

				return result;
			};
		}

		it('calls the original function', function() {

			var callback = sinon.spy();
			var proxy = once(callback);

			proxy();

			expect(callback.called).to.be.true;

		});

		it(".calledOnce returns whether a spy has been called only once", function () {
		    var callback = sinon.spy();
		    var proxy = once(callback);

		    proxy();
		    proxy();

		    expect(callback.calledOnce).to.be.true;
		});

		it(".callCount returns the number of times a spy is called", function() {
			var callback = sinon.spy();
		    var proxy = function () { callback(); };

		    proxy();
		    proxy();

		    expect(callback.callCount).to.equal(2);
		});

		it(".calledWith returns whether a spy was called with the specified arguments", function() {
			var callback = sinon.spy();
		    var proxy = function (a, b, c) { callback(a, b, c); };
		    var a, b, c;

		    proxy(1, 2, 3);

		    expect(callback.calledWith(1, 2, 3)).to.equal(true);
		    expect(callback.calledWith(1, 2)).to.equal(true);
		    expect(callback.calledWith(1)).to.equal(true);
		    expect(callback.calledWith(2)).to.equal(false);

		    callback = sinon.spy();
		    proxy(a, b, c);
		    expect(callback.calledWith(1, 2, 3)).to.equal(false);
		    expect(callback.calledWith(a, b, c)).to.equal(true);
		});

		it(".calledOn returns whether a spy was called on an object", function() {
			var callback = sinon.spy();
		    var proxy = function() { callback.call(this); };
		    var obj = {};

		    proxy.call(obj);

		    expect(callback.calledOn(obj)).to.equal(true);
		});

	});

});