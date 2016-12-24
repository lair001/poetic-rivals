describe('chai expect assertions', function() {

  "use strict";

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

  it(".a and .an can be used to assert a value's type", function() {
    expect('test').to.be.a('string');
    expect({ foo: 'bar' }).to.be.an('object');
    expect(null).to.be.a('null');
    expect(undefined).to.be.an('undefined');
    expect(new Error).to.be.an('error');
    expect(new Float32Array()).to.be.a('float32array');
  });

  it(".a and .an can be used as language chains", function() {
    expect([]).to.be.an.instanceof(Array);
  })

  it(".include and .contain can be used to assert inclusion or as language chains", function() {
    expect([1,2,3]).to.include(2);
    expect('foobar').to.contain('foo');
    expect({ foo: 'bar', hello: 'universe' }).to.include.keys('foo');
  });

  it(".ok asserts truthiness", function() {
    expect('everything').to.be.ok;
    expect(1).to.be.ok;
    expect(false).to.not.be.ok;
    expect(undefined).to.not.be.ok;
    expect(null).to.not.be.ok;
  });

  it(".true asserts that the target is equal to true", function() {
    expect(true).to.be.true;
    expect(1).to.not.be.true;
    expect(!!1).to.be.true;
  });

  it(".false asserts that the target is equal to false", function() {
    expect(false).to.be.false;
    expect(0).to.not.be.false;
    expect(!!0).to.be.false;
  });

  it(".null asserts that the target is equal to null", function() {
    var myNullValue = null;
    expect(null).to.be.null;
    expect(undefined).to.not.be.null;
    expect(myNullValue).to.be.null;
  });

  it(".undefined asserts that the target is equal to undefined", function() {
    var myUndefinedValue = undefined;
    var foo = {};
    expect(undefined).to.be.undefined;
    expect(null).to.not.be.undefined;
    expect(myUndefinedValue).to.be.undefined;
    expect(foo.bar).to.be.undefined;
  });

  it(".NaN asserts that the target is not a number", function() {
    expect('foo').to.be.NaN;
    expect(4).not.to.be.NaN;
    expect(7.7).to.be.not.NaN;
    expect([]).to.not.be.NaN; // JS: violating the principle of least suprise since 1995
    expect({}).to.be.NaN;
    expect(NaN).to.be.NaN;
  });

  it(".exist asserts that the target in neither null nor undefined", function() {
    var foo = 'hi'
      , bar = null
      , baz;

    expect(foo).to.exist;
    expect(bar).to.not.exist;
    expect(baz).to.not.exist;
    expect([]).to.exist;
    expect({}).to.exist;
    expect(0).to.exist;
    expect(3.14).to.exist;
    expect(false).to.exist;
    expect(/foo/).to.exist;
  })

  it(".empty asserts that the target's length is 0. (Literally checks length for arrays and strings. Counts keys for objects)", function() {
    expect([]).to.be.empty;
    expect('').to.be.empty;
    expect({}).to.be.empty;
    expect([1]).to.not.be.empty;
    expect('foo').to.not.be.empty;
    expect({foo: 'bar'}).to.not.be.empty;
    expect(/foo/).to.be.empty;
    expect({ length: 0 }).to.not.be.empty;
  });

  it(".arguments asserts that the target is an arguments object", function() {
    expect(arguments).to.be.arguments;
  });

  it(".equal asserts that the target is strictly equal (===) to value", function() {
    expect('hello').to.equal('hello');
    expect(42).to.equal(42);
    expect(1).to.not.equal(true);
    expect({ foo: 'bar' }).to.not.equal({ foo: 'bar' });

    // here we can see a difference between strictly equal and deeply equal
    expect({ foo: 'bar' }).to.deep.equal({ foo: 'bar' });
  });

  it(".eql asserts that target is deeply equal to value", function() {
    expect({ foo: 'bar' }).to.eql({ foo: 'bar' });
    expect([ 1, 2, 3 ]).to.eql([ 1, 2, 3 ]);
  });

  it(".above asserts that target is greater than value", function() {
    expect(10).to.be.above(5);
    expect(11).to.not.be.above(22);

    expect('foo').to.have.length.above(2);
    expect([ 1, 2, 3 ]).to.have.length.above(2);
  });

  it('.least asserts that the target is greater than or equal to value', function() {
    expect(10).to.be.at.least(10);
    expect('foo').to.have.length.of.at.least(2);
    expect([ 1, 2, 3 ]).to.have.length.of.at.least(3);
  });

  it('.below asserts that the target is less than value', function() {
    expect(5).to.be.below(10);

    expect('foo').to.have.length.below(4);
    expect([ 1, 2, 3 ]).to.have.length.below(4);
  });

  it('.most asserts that the target is less than or equal to value', function() {
    expect(5).to.be.at.most(5);

    expect('foo').to.have.length.of.at.most(4);
    expect([ 1, 2, 3 ]).to.have.length.of.at.most(3);
  });

  it('.within asserts that the target is within a range', function() {
    expect(7).to.be.within(5,10);

    expect('foo').to.have.length.within(2,4);
    expect([ 1, 2, 3 ]).to.have.length.within(2,4);
  });

  it('.instanceof asserts that the target is an instance of constructor', function() {
    var Tea = function (name) { this.name = name; }
      , Chai = new Tea('chai');

    expect(Chai).to.be.an.instanceof(Tea);
    expect([ 1, 2, 3 ]).to.be.instanceof(Array);
  });

  describe('.property', function() {

    it('asserts that the target has a property name', function() {
      var obj = { foo: 'bar' };
      expect(obj).to.have.property('foo');
    });

    it('can optionally assert that the value of the property is strictly equal to value', function() {
      var obj = { foo: 'bar' };
      expect(obj).to.have.property('foo', 'bar');
    });

    it('can deeply reference by setting the deep flag and using dot- and bracket- notation', function() {
      var deepObj = {
          green: { tea: 'matcha' }
        , teas: [ 'chai', 'matcha', { tea: 'konacha' } ]
      };

      expect(deepObj).to.have.deep.property('green.tea', 'matcha');
      expect(deepObj).to.have.deep.property('teas[1]', 'matcha');
      expect(deepObj).to.have.deep.property('teas[2].tea', 'konacha');

    });

    it('can also use an array as the starting point of deep assertion', function() {
      var arr = [
          [ 'chai', 'matcha', 'konacha' ]
          , [ { tea: 'chai' }
          , { tea: 'matcha' }
          , { tea: 'konacha' } ]
      ];

      expect(arr).to.have.deep.property('[0][1]', 'matcha');
      expect(arr).to.have.deep.property('[1][2].tea', 'konacha');

    });

    it('changes the subject of further assertions to the value of the property', function() {

      var obj = { foo: 'bar' };
      var deepObj = {
          green: { tea: 'matcha' }
        , teas: [ 'chai', 'matcha', { tea: 'konacha' } ]
      };

      expect(obj).to.have.property('foo')
        .that.is.a('string');
      expect(deepObj).to.have.property('green')
        .that.is.an('object')
        .that.deep.equals({ tea: 'matcha' });
      expect(deepObj).to.have.property('teas')
        .that.is.an('array')
        .with.deep.property('[2]')
          .that.deep.equals({ tea: 'konacha' });

    });

    it('requires: dots and bracket in name must be backslash-escaped when the deep flag is set, while they must NOT be escaped when the deep flag is not set', function() {
      var css = { '.link[target]': 42 };
      expect(css).to.have.property('.link[target]', 42);

      // deep referencing
      var deepCss = { '.link': { '[target]': 42 }};
      expect(deepCss).to.have.deep.property('\\.link.\\[target\\]', 42);
    });


  });

  it('.ownProperty', function() {
    var box = { width: 10 };
    expect('test').to.have.ownProperty('length');
    expect(box).to.have.ownProperty('width');
  });

  describe('.ownPropertyDescriptor', function() {

    it('asserts that target has an own property descriptor', function() {
      var box = { width: 10 };
      expect(box).to.have.ownPropertyDescriptor('width');
      expect('test').to.have.ownPropertyDescriptor('length');
      expect('test').ownPropertyDescriptor('length').to.have.property('enumerable', false);
      // expect('test').ownPropertyDescriptor('length').to.have.keys('value');
    });

    it('can optionally match a descriptor', function() {
      expect('test').to.have.ownPropertyDescriptor('length', { enumerable: false, configurable: false, writable: false, value: 4 });
      expect('test').not.to.have.ownPropertyDescriptor('length', { enumerable: false, configurable: false, writable: false, value: 3 });
    });

  });

  it('.length sets the doLength flag later used as a chain precursor to a value comparison for the length property', function() {
    expect('foo').to.have.length.above(2);
    expect([ 1, 2, 3 ]).to.have.length.above(2);
    expect('foo').to.have.length.below(4);
    expect([ 1, 2, 3 ]).to.have.length.below(4);
    expect('foo').to.have.length.within(2,4);
    expect([ 1, 2, 3 ]).to.have.length.within(2,4);
  });

  it(".lengthOf asserts the target's length", function() {
    expect([ 1, 2, 3]).to.have.lengthOf(3);
    expect('foobar').to.have.lengthOf(6);
  });

  it(".match asserts that the target matches a regex", function() {
    expect('foobar').to.match(/^foo/);
  });

  it(".string asserts that the target string contains another string", function() {
    expect('foobar').to.have.string('bar');
  });

  it(".keys asserts that the target contains any or all of the passed-in keys (dependent on other assertions)", function() {
    expect({ foo: 1, bar: 2 }).to.have.any.keys('foo', 'baz');
    expect({ foo: 1, bar: 2 }).to.have.any.keys('foo');
    expect({ foo: 1, bar: 2 }).to.contain.any.keys('bar', 'baz');
    expect({ foo: 1, bar: 2 }).to.contain.any.keys(['foo']);
    expect({ foo: 1, bar: 2 }).to.contain.any.keys({'foo': 6});
    expect({ foo: 1, bar: 2 }).to.have.all.keys(['bar', 'foo']);
    expect({ foo: 1, bar: 2 }).to.have.all.keys({'bar': 6, 'foo': 7});
    expect({ foo: 1, bar: 2, baz: 3 }).to.contain.all.keys(['bar', 'foo']);
    expect({ foo: 1, bar: 2, baz: 3 }).to.contain.all.keys({'bar': 6});
  });

  describe('.throw', function() {

    it('can assert that a specific error is thrown', function() {
      var err = new ReferenceError('This is a bad function.');
      var anotherErr = new ReferenceError('This is a bad function.');
      var fn = function () { throw err; };

      expect(fn).to.throw(err);
      expect(fn).to.not.throw(anotherErr);

    });

    it('can assert that a specific type of error is thrown', function() {
      var err = new ReferenceError('This is a bad function.');
      var fn = function () { throw err; };
      expect(fn).to.throw(ReferenceError);
      expect(fn).to.throw(Error);
    });

    it("can assert that a thrown error's message contains a string or matches a regex", function() {
      var err = new ReferenceError('This is a bad function.');
      var fn = function () { throw err; };
      expect(fn).to.throw(/bad function/);
      expect(fn).to.not.throw('good function');
      expect(fn).to.throw('bad function');
      expect(fn).to.throw(ReferenceError, /bad function/);
    });

  });

  it(".respondTo asserts that the target object or class responds to a method", function() {

    var Klass = function(){};
    var obj = new Klass();
    var newObj;
    Klass.prototype.bar = function(){};

    expect(Klass).to.respondTo('bar');
    // modifying a class's prototype affects preexisting instances
    expect(obj).to.respondTo('bar');

    // use itself to assert whether constructor will respond to a method

    Klass.baz = function(){};
    expect(Klass).itself.to.respondTo('baz');
    expect(Klass).itself.to.not.respondTo('bar');
    expect(obj).to.not.respondTo('baz');
    newObj = new Klass();
    expect(newObj).to.not.respondTo('baz');

  });

  it(".itself sets the itself flag used by .respondTo", function() {
    function Foo() {}
    Foo.bar = function() {}
    Foo.prototype.baz = function() {}

    expect(Foo).itself.to.respondTo('bar');
    expect(Foo).itself.not.to.respondTo('baz');
  });

  it('.satisfy asserts that the target passes a truth test provided by a function', function() {
    expect(1).to.satisfy(function(num) { return num > 0; })
  });

  it('.closeTo asserts that a target is within a delta of a value', function() {
    expect(0.4).to.not.be.closeTo(1, 0.5);    
    expect(0.5).to.be.closeTo(1, 0.5);
    expect(0.6).to.be.closeTo(1, 0.5);
    expect(1).to.be.closeTo(1, 0.5);
    expect(1.4).to.be.closeTo(1, 0.5);
    expect(1.5).to.be.closeTo(1, 0.5);
    expect(1.6).to.not.be.closeTo(1, 0.5);
  });

  it('.members asserts that the target is a superset of the value', function() {
    expect([1, 2, 3]).to.include.members([3, 2]);
    expect([1, 2, 3]).to.not.include.members([3, 2, 8]);

    expect([4, 2]).to.have.members([2, 4]);
    expect([5, 2]).to.not.have.members([5, 2, 1]);

    expect([{ id: 1 }]).to.deep.include.members([{ id: 1 }]);
  });

  it('.oneOf asserts that the target is in the top level of the array value', function() {
    expect('a').to.be.oneOf(['a', 'b', 'c']);
    expect(9).to.not.be.oneOf(['z']);
    expect([3]).to.not.be.oneOf([1, 2, [3]]);

    var three = [3];
    // for object-types, contents are not compared
    expect(three).to.not.be.oneOf([1, 2, [3]]);
    // comparing references works
    expect(three).to.be.oneOf([1, 2, three]);
  });

  it(".change asserts that the target function changes the value object's property", function() {
    var obj = { val: 10 };
    var fn = function() { obj.val += 3 };
    var noChangeFn = function() { return 'foo' + 'bar'; };
    expect(fn).to.change(obj, 'val');
    expect(noChangeFn).to.not.change(obj, 'val');
  });

  it(".increase asserts that the target function increases the value object's property", function() {
    var obj = { val: 10 };
    var fn = function() { obj.val = 15 };
    expect(fn).to.increase(obj, 'val');
  });

  it(".decrease asserts that the target function decreases the value object's property", function() {
    var obj = { val: 10 };
    var fn = function() { obj.val = 5 };
    expect(fn).to.decrease(obj, 'val');
  });

  it(".extensible asserts that the target is extensible (can have new properties added to it).", function() {
    var nonExtensibleObject = Object.preventExtensions({});
    var sealedObject = Object.seal({});
    var frozenObject = Object.freeze({});

    expect({}).to.be.extensible;
    expect(nonExtensibleObject).to.not.be.extensible;
    expect(sealedObject).to.not.be.extensible;
    expect(frozenObject).to.not.be.extensible;
  });

  it('.sealed asserts that the target is sealed (cannot have new properties added to it and its existing properties cannot be removed).', function() {
    var sealedObject = Object.seal({});
    var frozenObject = Object.freeze({});

    expect(sealedObject).to.be.sealed;
    expect(frozenObject).to.be.sealed;
    expect({}).to.not.be.sealed;
  });

  it('.frozen asserts that the target is frozen (cannot have new properties added to it and its existing properties cannot be modified).', function() {
    var frozenObject = Object.freeze({});

    expect(frozenObject).to.be.frozen;
    expect({}).to.not.be.frozen;
  });

});