describe("chai-jq (jQuery tests)", function() {


  // $visible and $hidden are both acting strangely
  it('can test for visible elements', function() {
    expect($("<div>&nbsp;</div>"))
      .to.be.$visible;
  });

  // $visible and $hidden are both acting strangely
  it('can test for hidden elements', function() {
    expect($("<div style=\"display: none\" />")).to.be.$hidden;
  });

  it('can test for input value', function() {
    expect($("<input value='foo' />")).to.have.$val("foo").and.to.have.$val(/^foo/);
  });

  it('can test for classes', function() {
    expect($("<div class='foo bar' />"))
      .to.have.$class("foo")
      .and.to.have.$class("bar");
  });

  it('can test for attributes', function() {
    expect($("<div id=\"hi\" foo=\"bar time\" />"))
      .to.have.$attr("id", "hi").and
      .to.contain.$attr("foo", "bar");

    expect($("<div id=\"hi\" foo=\"bar time\" />"))
      .to.have.$attr("foo").and
      .to.equal("bar time").and
      .to.match(/^b/);
  });

  it('can test datasets', function() {
    expect($("<div data-id=\"hi\" data-foo=\"bar time\" />"))
      .to.have.$data("id", "hi").and
      .to.contain.$data("foo", "bar");

    expect($("<div data-id=\"hi\" data-foo=\"bar time\" />"))
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
    expect($("<div><span>foo</span></div>"))
      .to.have.$html("<span>foo</span>").and
      .to.contain.$html("foo");
  });

  it('can test text', function() {
    expect($("<div><span>foo</span> bar</div>"))
      .to.have.$text("foo bar").and
      .to.contain.$text("foo");
  });

  it('can test css', function() {
  expect($("<div style=\"width: 50px; border: 1px dotted black;\" />"))
    .to.have.$css("width", "50px").and
    .to.have.$css("border-top-style", "dotted");
  });

});