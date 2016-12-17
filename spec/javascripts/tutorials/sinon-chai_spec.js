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


});