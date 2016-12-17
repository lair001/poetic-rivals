
describe('sinon', function() {

	function getTodos(listId, callback) {
	    jQuery.ajax({
	        url: "/todo/" + listId + "/items",
	        success: function (data) {
	            // Node-style CPS: callback(err, data)
	            callback(null, data);
	        }
	    });
	}

	function throttle(callback) {
	    var timer;
	    return function () {
	        clearTimeout(timer);
	        var args = [].slice.call(arguments);
	        timer = setTimeout(function () {
	            callback.apply(this, args);
	        }, 100);
	    };
	}

	describe('spies', function() {

		var once = modules.Utils.once;

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

		describe("stubs", function() {

			it('can be used to confirm that once returns the same value as the original function', function() {

				var callback = sinon.stub().returns(42);
    			var proxy = once(callback);

    			expect(proxy()).to.equal(42);

			});

			it('can do anything that a regular spy can', function() {
				var callback = sinon.stub();
				var proxy = function(a, b, c) { callback.call(this, a, b, c); };
				var obj = {};

		    	proxy();

		    	expect(callback.calledOnce).to.be.true;

		    	proxy();

		    	expect(callback.callCount).to.equal(2);

		    	proxy.call(obj, 1, 2 ,3);

		    	expect(callback.calledOn(obj)).to.equal(true);
		    	expect(callback.calledWith(1, 2, 3)).to.equal(true);
		    	expect(callback.callCount).to.equal(3);
			});

			it('can be used to test ajax', function () {

			    sinon.stub(jQuery, "ajax"); // replacing jQuery with a stub that has a stubbed ajax method
			    getTodos(42, sinon.spy());

			    expect(jQuery.ajax.calledWithMatch({ url: "/todo/42/items" })).to.be.true; // another method from the spy/stub api is introduced

			    jQuery.ajax.restore(); // restore jquery
			});

		});

	});

	it('fake XMLHttpRequest is the preferred way of testing ajax since stubs are too closely tied to implementation', function() {

		var xhr = sinon.useFakeXMLHttpRequest();
	    var requests = [];
	    xhr.onCreate = function (req) { requests.push(req); };

	    getTodos(42, sinon.spy());

	    expect(requests).to.have.lengthOf(1);
	    expect(requests[0].url).to.match(/^\/todo\/42\/items$/);

	    xhr.restore();
	});

	it('Fake Server can simplify some tests compared to Fake XMLHttpRequest', function() {

		var server = sinon.fakeServer.create();
	    var callback = sinon.spy();
	    getTodos(42, callback);

	    server.requests[0].respond(
	        200,
	        { "Content-Type": "application/json" },
	        JSON.stringify([{ id: 1, text: "Provide examples", done: true }])
	    );

	    expect(callback.calledOnce).to.be.true;

		server.restore();

	});

	it('can fake time (ie fake wait/sleep/timeout without actually stopping)', function() {

		var clock = sinon.useFakeTimers();

	    var callback = sinon.spy();
	    var throttled = throttle(callback);

	    throttled();

	    clock.tick(99);

	    expect(callback.notCalled).to.be.true;

	    clock.tick(1);

	    expect(callback.calledOnce).to.be.true;

		clock.restore();
	});

});