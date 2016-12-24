fixture.preload("tutorials/chai-jq-forms.html")

describe("chai-jq examples with forms in the fixture", function() {

  "use strict";

  beforeEach(function() {
    this.fixtures = fixture.load("tutorials/chai-jq-forms.html")
  });

  it('can find the first form by a simple tag selector', function() {
  	expect($("form")).to.have.$class('form-1');
  });

  it('can find the first form by id', function() {
  	expect($("#form_1")).to.have.$class('form-1');
  });

  it('can find the second form by id', function() {
  	expect($("#form_2")).to.have.$class('form-2');
  });

  it('can find the first input by a simple tag selector', function() {
    expect($("input")).to.have.$val("foo").and.to.have.$val(/^foo/);
  });

  it('can find first input by id', function() {
    expect($("#value")).to.have.$val("foo").and.to.have.$val(/^foo/);
  });

  it('can find second input by id', function() {

    expect($("#checkbox"))
     .to.have.$prop("checked", true).and
     .to.have.$prop("type", "checkbox");


     expect($("#checkbox"))
      .to.have.$prop("type").and
      .to.equal("checkbox").and
      .to.match(/^c.*x$/);

  });

});