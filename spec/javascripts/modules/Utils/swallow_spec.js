describe('Utils#swallow', function() {

	it('rescues from a thrown error', function() {

		var swallow = modules.Utils.swallow;
		var spy = sinon.spy(function() { throw new Error("boo!"); });
		swallow(spy);
		expect(spy).to.have.thrown();

	});

});