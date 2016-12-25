describe('PoeticRivals.factories.page#Aqm', function() {

	"use strict";

	var aqmPage;
	var Aqm = modules.PoeticRivals.factories.page.Aqm;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/page/Aqm.html")
		aqmPage = new Aqm();
	});

	describe('processQuote', function() {
		it('loads data from a quote JSON into the DOM', function() {
			var quoteJSON = {
				"author": "Pablo Picasso",
				"quote": "Give me a museum and I'll fill it."
			}
			aqmPage.processQuote(quoteJSON);
			expect($("#aqm_quote_edit")).to.contain.$text(quoteJSON.quote);
			expect($("#aqm_quote_footer")).to.contain.$text(quoteJSON.author);
			expect($("#aqm_tweet_link")).to.have.$attr("href", "https://twitter.com/intent/tweet?&text=" + quoteJSON.quote + " — " + quoteJSON.author);
		});
	});

	describe('getQuote', function() {

		it('makes an asynchronous post request to a random quote generator API', sinon.test(function() {
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };

		    aqmPage.getQuote();
		    expect(requests[0].url.toLowerCase()).to.equal("https://andruxnet-random-famous-quotes.p.mashape.com/");
		    expect(requests[0].method.toUpperCase()).to.equal("POST");
		    expect(requests[0].async).to.be.true;
		    expect(requests[0].requestHeaders.Accept.toLowerCase()).to.contain("application/json");
		    expect(requests[0].requestHeaders["Content-Type"].toLowerCase()).to.contain("application/x-www-form-urlencoded");
		    expect(requests[0].requestHeaders["X-Mashape-Key"]).to.be.a('string');
		}));

		it('executes processQuote when request is successful', sinon.test(function() {
			var body = '{"quote":"Problems worthy of attack prove their worth by fighting back.","author":"Paul Erdos","category":"Famous"}';
			var spy1 = this.spy(aqmPage, "processQuote");
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };

		    aqmPage.getQuote();
		    requests[0].respond(200, { "Content-Type": "application/json" }, body);
		    expect(spy1).to.have.been.called;
		}));

		it('executes handleAjaxError when request is unsuccessful', sinon.test(function() {
			var spy1 = this.spy(aqmPage, "handleAjaxError");
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };

		    aqmPage.getQuote();
		    requests[0].respond(500, {}, "");
		    expect(spy1).to.have.been.called;
		}));

	});

});