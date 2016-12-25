describe('PoeticRivals.factories.page#Aqm', function() {

	"use strict";

	var aqmPage;
	var Aqm = modules.PoeticRivals.factories.page.Aqm;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/page/Aqm.html")
		aqmPage = new Aqm();
	});

	describe("generateColors", function() {
		it("returns a color pair", function() {
			var colors = aqmPage.generateColors();
			expect(colors.bkgrndclr).to.match(/^(#[a-fA-F\d]{6}|#[a-fA-F\d]{3}|rgb\((\d){1,3}, (\d){1,3}, (\d){1,3}\))$/);
			expect(colors.txtclr).to.match(/^(#[a-fA-F\d]{6}|#[a-fA-F\d]{3}|rgb\((\d){1,3}, (\d){1,3}, (\d){1,3}\))$/);
		});
	});

	describe('setColors', function() {
		it("changes the page's color scheme given a pair of colors", function() {
			var colors = {"bkgrndclr":"rgb(89, 130, 52)", "txtclr":"rgb(5, 81, 96)"};
			aqmPage.setColors(colors);
			expect($("#aqm_quote_jumbotron")).to.have.$css("background-color", colors.bkgrndclr).and.to.have.$css("color", colors.txtclr);
			expect($("#aqm_quote_block")).to.have.$css("border-color", colors.txtclr);
			expect($("#aqm_quote_footer")).to.have.$css("color", colors.txtclr);
			expect($("#aqm_get_quote")).to.have.$css("background-color", colors.txtclr).and.to.have.$css("border-color", colors.txtclr).and.to.have.$css("color", colors.bkgrndclr);
			expect($("#aqm_tweet_quote")).to.have.$css("background-color", colors.txtclr).and.to.have.$css("border-color", colors.txtclr).and.to.have.$css("color", colors.bkgrndclr);
			expect($("#aqm_tweet_link")).to.have.$css("color", colors.bkgrndclr);
		});
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

	describe('onGetQuoteClick', function() {
		it('sets a click event on #aqm_get_quote', function() {
			var aqmGetQuoteButton = document.getElementById("aqm_get_quote");
			aqmPage.onGetQuoteClick();
			expect(!!$._data(aqmGetQuoteButton, "events").click).to.be.true;
		});

		it('when the click event is triggered, #setColors, #generateColors, and #getQuote are called', sinon.test(function() {
			var spy1 = this.spy(aqmPage, "setColors");
			var spy2 = this.spy(aqmPage, "generateColors");
			var spy3 = this.spy(aqmPage, "getQuote");
			var colorPairMatcher = sinon.match(function(value) {
				return typeof(value.bkgrndclr) === 'string'
					&& typeof(value.txtclr) === 'string'
					&& value.bkgrndclr.match(/^(#[a-fA-F\d]{6}|#[a-fA-F\d]{3}|rgb\((\d){1,3}, (\d){1,3}, (\d){1,3}\))$/)
					&& value.txtclr.match(/^(#[a-fA-F\d]{6}|#[a-fA-F\d]{3}|rgb\((\d){1,3}, (\d){1,3}, (\d){1,3}\))$/);
			}, "Must be called with a color pair.")
			aqmPage.onGetQuoteClick();
			$("#aqm_get_quote").trigger("click");
			expect(spy1).to.have.been.calledWith(colorPairMatcher);
			expect(spy2).to.have.been.called;
			expect(spy3).to.have.been.called;
		}));
	});

});