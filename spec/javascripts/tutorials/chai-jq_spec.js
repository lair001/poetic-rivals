fixture.preload("tutorials/chai-jq.html")

describe("chai-jq (jQuery tests)", function() {

  beforeEach(function() {
    this.fixtures = fixture.load("tutorials/chai-jq.html")
  });

  it('can test for visible elements', function() {
    expect($('#visible'))
      .to.be.$visible;
  });

  it('can test for hidden elements', function() {
    expect($("#hidden")).to.be.$hidden;
  });

  it('can test for input value', function() {
    expect($("<input value='foo' />")).to.have.$val("foo").and.to.have.$val(/^foo/);
  });

  it('can test for classes', function() {
    expect($(".foo.bar"))
      .to.have.$class("foo")
      .and.to.have.$class("bar");
  });

  it('can test for attributes', function() {
    expect($("#hi"))
      .to.have.$attr("id", "hi").and
      .to.contain.$attr("foo", "bar");

    expect($("#hi"))
      .to.have.$attr("foo").and
      .to.equal("bar time").and
      .to.match(/^b/);
  });

  it('can test datasets', function() {
    expect($("#data"))
      .to.have.$data("id", "hi").and
      .to.contain.$data("foo", "bar");

    expect($("#data"))
      .to.have.$data("foo").and
      .to.equal("bar time").and
      .to.match(/^b/);
  });

  it('can test properties', function() {

    expect($("<input type=\"checkbox\" checked=\"checked\" />"))
     .to.have.$prop("checked", true).and
     .to.have.$prop("type", "checkbox");


     expect($("<input type=\"checkbox\" checked=\"checked\" />"))
      .to.have.$prop("type").and
      .to.equal("checkbox").and
      .to.match(/^c.*x$/);

  });

  it('can test html', function() {
    expect($("#html"))
      .to.have.$html("<span>foo</span>").and
      .to.contain.$html("foo");
  });

  it('can test text', function() {
    expect($("#text"))
      .to.have.$text("foo bar").and
      .to.contain.$text("foo");
  });

  it('can test css', function() {
  expect($("#css"))
    .to.have.$css("width", "50px").and
    .to.have.$css("border-top-style", "dotted");
  });

});