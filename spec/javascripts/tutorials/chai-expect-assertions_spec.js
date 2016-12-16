describe('chai expect assertions', function() {

  it('.not negates any of the assertions following in the chain', function() {
    var foo = 'foo';
    function goodFn() {}

    expect(foo).to.not.equal('bar');
    expect(goodFn).to.not.throw(Error);
    expect({ foo: 'baz' }).to.have.property('foo')
      .and.not.equal('bar');
  });

  it('.deep sets the deep flag later used by equal and property assertions', function() {
    var fooAlpha = { bar: 'baz' };
    var fooBeta = { bar: 'baz' };

    expect(fooAlpha).to.deep.equal(fooBeta);
    expect({ foo: { bar: { baz: 'quux' } } })
      .to.have.deep.property('foo.bar.baz', 'quux');
  });

  it('.any sets the any flag (opposite of all)', function() {

    var foo = { bar: 'ipsum' };
    expect(foo).to.have.any.keys('bar', 'baz');

  });

  it('.all sets the all flag (opposite of any)', function() {
    var foo = { bar: 'ipsum', baz: 'lorem' }
    expect(foo).to.have.all.keys('bar', 'baz');
    expect(foo).to.not.have.all.keys('bar', 'baz', 'quux');
  });

});