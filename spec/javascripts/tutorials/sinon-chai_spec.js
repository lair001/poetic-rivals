describe('sinon-chai', function() {

	var swallow = modules.Utils.swallow;

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

	describe('Returning', function() {

			var i, spy1, spy2;

			var testFn1 = function() {
					return ++i;
				}

			var testFn2 = function() {
				return 2;
			}

			beforeEach(function() {
				i = 0;
				spy1 = sinon.spy(testFn1);
				spy2 = sinon.spy(testFn2);
			});

		describe('returned', function() {

			it('is satisfied if the spy returns the specified value', function() {
				spy1();
				expect(spy1).to.have.returned(1);
				spy1();
				expect(spy1).to.have.returned(2);
				expect(spy1).to.have.returned(1);
				expect(spy1.getCall(0)).to.have.returned(1);
				expect(spy1.getCall(1)).to.have.returned(2);
				expect(spy1.getCall(1)).to.not.have.returned(1);
			});

		});

		describe('always returned', function() {

			it('is satisfied if the target spy has been called at least once and all calls of the spy have returned the specified value', function() {
				expect(spy1).to.not.have.always.returned(1);
				expect(spy2).to.not.have.always.returned(2);
				spy1();
				expect(spy1).to.have.always.returned(1);
				spy2();
				expect(spy2).to.have.always.returned(2);
				spy1();
				expect(spy1).to.not.have.always.returned(1);
				spy2();
				expect(spy2).to.have.always.returned(2);
			});

		});

		describe('Throwing', function() {

			var error1, spy1, error2, spy2, error3, spy3, spy4, i, spy5;

			beforeEach(function() {
				error1 = new Error("boo!");
				spy1 = sinon.spy(function() { throw error1; } );
				error2 = new Error("wah!");
				spy2 = sinon.spy(function() { throw error2; } );
				error3 = new TypeError("eek!")
				spy3 = sinon.spy(function() { throw error3; } );
				spy4 = sinon.spy();
				i = -1;
				spy5 = sinon.spy(function() {
					i++;
					if (i % 4 === 0) {
						throw error1;
					} else if (i % 4 === 1) {
						throw error2;
					} else if (i % 4 === 2) {
						throw error3;
					} else if (i % 4 === 3) {

					}
				});
			});

			describe('thrown', function() {

				it('is satisfied when no error is specified if the spy throws any error', function() {
					expect(spy1).to.not.have.thrown;
					swallow(spy1);
					expect(spy1).to.have.thrown;
					expect(spy2).to.not.have.thrown;
					swallow(spy2);
					expect(spy2).to.have.thrown;
					spy4();
					expect(spy4).to.not.have.thrown;
				});

				it('is satisfied when an error object is specified if the spy throws the specified error object', function() {
					swallow(spy1);
					swallow(spy2);
					expect(spy1).to.have.thrown(error1);
					expect(spy1).to.not.have.thrown(error2);
					expect(spy2).to.have.thrown(error2);
					expect(spy2).to.not.have.thrown(error1);
				});

				it('is satisfed when an error type is specified if the spy throws an error of the specified type', function() {
					swallow(spy1);
					swallow(spy2);
					expect(spy1).to.not.have.thrown("TypeError");
					expect(spy2).to.not.have.thrown("TypeError");
					swallow(spy3);
					expect(spy3).to.have.thrown("TypeError");
				});

			});

			describe("always thrown", function() {
				it('is satisfied when no error is specified if the spy has been called at least once and has thrown an error on every call', function() {
					expect(spy1).to.not.have.always.thrown;
					expect(spy2).to.not.have.always.thrown;
					swallow(spy1);
					swallow(spy2);
					expect(spy1).to.have.always.thrown;
					expect(spy2).to.have.always.thrown;
					swallow(spy1);
					swallow(spy2);
					expect(spy1).to.have.always.thrown;
					expect(spy2).to.have.always.thrown;
					swallow(spy5);
					swallow(spy5);
					swallow(spy5);
					expect(spy5).to.have.always.thrown;
					spy5();
					expect(spy5).to.not.have.always.thrown;
				});

				it('is satisfied when an error object is specified if the spy has been called at least once and has thrown the specified error object on every call', function() {
					expect(spy1).to.not.have.always.thrown(error1);
					expect(spy5).to.not.have.always.thrown(error1);
					swallow(spy1);
					swallow(spy5);
					expect(spy1).to.have.always.thrown(error1);
					expect(spy5).to.have.always.thrown(error1);
					swallow(spy1);
					swallow(spy5);
					expect(spy1).to.have.always.thrown(error1);
					expect(spy5).to.not.have.always.thrown(error1);
				});

				it('is satisfied when an error type is specified if the spy has been called at least once and has thrown the specified error type on every call', function() {
					expect(spy1).to.not.have.always.thrown('Error');
					expect(spy5).to.not.have.always.thrown('Error');
					swallow(spy1);
					swallow(spy5);
					expect(spy1).to.have.always.thrown('Error');
					expect(spy5).to.have.always.thrown('Error');
					swallow(spy1);
					swallow(spy5);
					expect(spy1).to.have.always.thrown('Error');
					expect(spy5).to.have.always.thrown('Error');
					swallow(spy1);
					swallow(spy5);
					expect(spy1).to.have.always.thrown('Error');
					expect(spy5).to.not.have.always.thrown('Error');
				});
			});
		});

	});


});