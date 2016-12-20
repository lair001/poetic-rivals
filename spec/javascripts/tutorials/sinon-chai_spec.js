describe('sinon-chai', function() {

	var hello = function(name, cb) {
    	cb("hello " + name);
	};

	it('passes simple example in the sinon-chai readme', function() {
        var cb = sinon.spy();

        hello("foo", cb);

        expect(cb).to.have.been.calledWith("hello foo");
	});

	describe('Call context', function() {

		var spy, target, notTheTarget;

		beforeEach(function() {
			spy = sinon.spy();
			target = {};
			notTheTarget = {};
		});

		describe("calledOn", function() {
			it('knows whether the spy has been called on the target', function() {
				expect(spy).not.to.have.been.calledOn(target);
				spy.call(notTheTarget);
				expect(spy).not.to.have.been.calledOn(target);
				spy.call(target);
				expect(spy).to.have.been.calledOn(target);
			});
		});

		describe("always calledOn", function() {
			it("is satsified if there is at least one call of the spy on the target and all calls of the spy are on the target but not satisfied if even one call of the spy is not on the target", function() {
				expect(spy).to.not.always.have.been.calledOn(target);
				spy.call(target);
				expect(spy).to.always.have.been.calledOn(target);
				spy.call(target);
				expect(spy).to.always.have.been.calledOn(target);
				spy.call(notTheTarget)
				expect(spy).to.not.always.have.been.calledOn(target);
			});
		});


	});

	describe('Call arguments', function() {
		var spy, arg1, arg2, notArg, any;

		beforeEach(function() {
			spy = sinon.spy();
			arg1 = "A";
			arg2 = "B";
			notArg = "C";
			any = sinon.match.any;
		});

		describe('calledWith', function() {
			it('knows whether the spy has been called with the specified arguments', function() {

				expect(spy).to.not.have.been.calledWith(arg1, arg2);
				spy(arg1, arg2);
				expect(spy).to.have.been.calledWith(arg1, arg2);
				expect(spy).to.not.have.been.calledWith(notArg);
				expect(spy).to.not.have.been.calledWith(arg2, arg1);
				spy(notArg, arg1);
				expect(spy).to.have.been.calledWith(notArg, arg1);
				expect(spy).to.have.been.calledWith(arg1, arg2);
				expect(spy).to.not.have.been.calledWith(notArg, arg2);
				expect(spy).to.not.have.been.calledWith(notArg, arg1, arg2);
				expect(spy).to.have.been.calledWith("A", "B");
			});
		});

		describe('always calledWith', function() {
			it('requires the spy to have been called at least once with the arguments and for all calls of the spy to include the arguments first', function() {
				expect(spy).to.not.have.always.been.calledWith(arg1, arg2);
				spy(arg1, arg2);
				expect(spy).to.have.always.been.calledWith(arg1, arg2);
				spy(arg1, arg2, notArg);
				expect(spy).to.have.always.been.calledWith(arg1, arg2);
				spy(notArg, arg1, arg2);
				expect(spy).to.not.have.always.been.calledWith(arg1, arg2);
			});
		});

		describe('calledWithExactly', function() {

			it('is similar to calledWith except no extra arguments are permitted', function() {
				expect(spy).to.not.have.been.calledWithExactly(arg1, arg2);
				spy(arg1, arg2, notArg);
				expect(spy).to.not.have.been.calledWithExactly(arg1, arg2);
				spy(arg1, arg2);
				expect(spy).to.have.been.calledWithExactly(arg1, arg2);
				spy(notArg);
				expect(spy).to.have.been.calledWithExactly(arg1, arg2);
			});

		});

		describe('always calledWithExactly', function() {
			it('requires the spy to be called with the exact arguments at least once and for all calls of the spy to have the exact arguments', function() {
				expect(spy).to.not.always.have.been.calledWithExactly(arg1, arg2);
				spy(arg1, arg2);
				expect(spy).to.always.have.been.calledWithExactly(arg1, arg2);
				spy(arg1, arg2, notArg);
				expect(spy).to.not.always.have.been.calledWithExactly(arg1, arg2);
			});
		});

		describe("calledWithMatch", function() {
			it('is similar to calledWith except the arguments are compared against a matcher like any boolean, any number, or any argument', function() {
				expect(spy).to.not.have.been.calledWithMatch(any, any);
				spy(any, any);
				expect(spy).to.have.been.calledWithMatch(any, any);
				spy(any);
				expect(spy).to.have.been.calledWithMatch(any, any);
				spy(any, any, any);
				expect(spy).to.have.been.calledWithMatch(any, any);
			});

			it('is similar to always calledWith except the arguments are compared against a matcher like any boolean, any number, or any argument', function() {
				expect(spy).to.not.always.have.been.calledWithMatch(any, any);
				spy(any, any);
				expect(spy).to.always.have.been.calledWithMatch(any, any);
				spy(any, any, any);
				expect(spy).to.always.have.been.calledWithMatch(any, any);
				spy(any);
				expect(spy).to.not.always.have.been.calledWithMatch(any, any);
			});
		});

	});

	describe('Call count', function() {

		var spy;

		beforeEach(function() {
			spy = sinon.spy();
		});

		describe('called', function() {

			it('is satisfied if spy is called at least once', function () {
				expect(spy).to.not.have.been.called;
				spy();
				expect(spy).to.have.been.called;
				spy();
				expect(spy).to.have.been.called;
			});

		});

		describe('callCount', function() {
			it('cannot be satisfied if no call count is specified', function() {
				expect(spy).to.not.have.callCount();
				spy();
				expect(spy).to.not.have.callCount();
			});
			it('is satisfied if the spy has been called the specified number of times', function() {
				expect(spy).to.have.callCount(0);
				expect(spy).to.not.have.callCount(1);
				expect(spy).to.not.have.callCount(2);
				spy();
				expect(spy).to.not.have.callCount(0);
				expect(spy).to.have.callCount(1);
				expect(spy).to.not.have.callCount(2);
				spy();
				expect(spy).to.not.have.callCount(0);
				expect(spy).to.not.have.callCount(1);
				expect(spy).to.have.callCount(2);
			});
		});

		describe('calledOnce', function() {
			it('is satisfied only when the spy is called exactly once', function() {
				expect(spy).to.not.have.been.calledOnce;
				spy();
				expect(spy).to.have.been.calledOnce;
				spy();
				expect(spy).to.not.have.been.calledOnce;
			});
		});

		describe('calledTwice', function() {
			it('is satisfied only if the spy is called exactly twice', function() {
				expect(spy).to.not.have.been.calledTwice;
				spy();
				expect(spy).to.not.have.been.calledTwice;
				spy();
				expect(spy).to.have.been.calledTwice;
				spy();
				expect(spy).to.not.have.been.calledTwice;
			});
		});

		describe('calledThrice', function() {
			it('is satisfied only if the spy is called exactly thrice', function() {
				expect(spy).to.not.have.been.calledThrice;
				spy();
				expect(spy).to.not.have.been.calledThrice;
				spy();
				expect(spy).to.not.have.been.calledThrice;
				spy();
				expect(spy).to.have.been.calledThrice;
				spy();
				expect(spy).to.not.have.been.calledThrice;
			})
		});

	});

	describe('Calling with new', function() {

		var spy;

		beforeEach(function() {
			spy = sinon.spy();
		});

		describe('calledWithNew', function() {

			it('is satisfied if the spy is called with the new keyword at least once', function() {
				expect(spy).to.not.have.been.calledWithNew;
				spy();
				expect(spy).to.not.have.been.calledWithNew;
				new spy();
				expect(spy).to.have.been.calledWithNew;
				spy();
				expect(spy).to.have.been.calledWithNew;
			});

		});

		describe('always calledWithNew', function() {

			it('is satisfied only if the spy has been called at least once and all calls of the spy have been with the new keyword', function() {
				expect(spy).to.not.have.been.always.calledWithNew;
				new spy();
				expect(spy).to.have.been.always.calledWithNew;
				new spy();
				expect(spy).to.have.been.always.calledWithNew;
				spy();
				expect(spy).to.not.have.been.always.calledWithNew;
			});

		});

	});

	describe('Call order', function() {

		var spy1, spy2;

		beforeEach(function() {
			spy1 = sinon.spy();
			spy2 = sinon.spy();
		});

		describe('calledBefore', function() {

			it('is satisfied if the target spy is called at least once and the first call of the target spy is before the first call of the value spy', function() {
				expect(spy1).to.not.have.been.calledBefore(spy2);
				spy1();
				expect(spy1).to.have.been.calledBefore(spy2);
				spy2();
				expect(spy1).to.have.been.calledBefore(spy2);
				spy1();
				expect(spy1).to.have.been.calledBefore(spy2);
			});

			it('is not satisfied if the value spy is called before the target spy', function() {
				spy2();
				expect(spy1).to.not.have.been.calledBefore(spy2);
				spy1();
				expect(spy1).to.not.have.been.calledBefore(spy2);
			});

		});

		describe('calledAfter', function() {
			it('is satisfied if the target spy has been called at least once after a call of the value spy, calls of the target spy are separated by at least one call of the value spy, and at least one call of the value spy follows a call of the target spy', function() {
				expect(spy1).to.not.have.been.calledAfter(spy2);
				spy2();
				expect(spy1).to.not.have.been.calledAfter(spy2);
				spy1();
				expect(spy1).to.have.been.calledAfter(spy2);
				spy2();
				expect(spy1).to.not.have.been.calledAfter(spy2);
				spy1();
				expect(spy1).to.have.been.calledAfter(spy2);
			});
		});

	});


});