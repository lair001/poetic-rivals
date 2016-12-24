describe("Testing", function() {

  "use strict";

  it("is going so smoothly", function() {
    expect(true).to.equal(true);
  });
  it("is a sad panda", function() {
    expect(!!null).to.equal(false);
  });
  it("1 + 1 = 2", function() {
    expect(1 + 1).to.equal(2);
  });
});

describe("Testing some more", function() {

    "use strict";

  it("jQuery is not undefined", function() {
    // expect(true).to.be(true);
    expect(typeof(jQuery)).to.not.equal('undefined');
  });

  it("hello matches hello", function() {
    expect('hello').to.match(/hello/);
  });

  it("hello does not match goodbye", function() {
    expect('hello').to.not.match(/goodbye/);
  });

  it("[1, 2, 3] has length 3", function() {
    expect([1, 2, 3]).to.have.length(3);
  });

});

// chai.js and expect.js do not seem to mix well
// describe('expect.js', function() {
//   it('ok asserts truthiness', function() {
//     expect(1).to.be.ok();
//     expect(true).to.be.ok();
//     expect({}).to.be.ok();
//     expect(0).to.not.be.ok();
//   });
// });