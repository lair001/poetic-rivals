describe('PoeticRivals.factories.page#Genre', function() {

	"use strict";

	var factories = modules.PoeticRivals.factories, Genre = factories.page.Genre, viewModelFactory = factories.viewModel, ShowableGenre = viewModelFactory.ShowableGenre, genrePage, pageData, dataset, genresCount, sortPosition, key, genreJSON;

	beforeEach(function() {
		fixture.load("modules/PoeticRivals/factories/page/Genre.html");
		pageData = document.getElementById('page_data');
		dataset = pageData.dataset;
	});

	it('creates a genre page with a genres count and a sort position', function() {
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = parseInt(dataset.sortPosition, 10);
		expect(genrePage.genresCount).to.equal(genresCount);
		expect(genrePage.sortPosition).to.equal(sortPosition);
	});

	it("creates a genre page with a sort position equal to half of the genres count rounded down if #page_data's dataset does not have a valid sort position and genres count is greater than or equal to 2", function() {
		dataset.sortPosition = "";
		dataset.genresCount = "115";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = Math.floor(genresCount/2);
		expect(genrePage.sortPosition).to.equal(sortPosition);

		dataset.genresCount = "2";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		sortPosition = Math.floor(genresCount/2);
		expect(genrePage.sortPosition).to.equal(sortPosition);
	});

	it("creates a genre page with a sort position equal to 1 if #page_data's dataset does not have a valid sort position and genres count is less than 2", function() {
		dataset.sortPosition = "";
		dataset.genresCount = "1";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		expect(genrePage.sortPosition).to.equal(1);

		dataset.genresCount = "0";
		genrePage = new Genre();
		genresCount = parseInt(dataset.genresCount, 10);
		expect(genrePage.sortPosition).to.equal(1);
	});

	describe('getGenre', function() {

		beforeEach(function() {
			genrePage = new Genre();
		});

		it('makes an asynchronous post request to a random quote generator API', sinon.test(function() {
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };
		    var spy1 = this.spy();

		    genrePage.getGenreJSON(spy1);
		    expect(requests[0].url.toLowerCase()).to.equal("/genres/" + genrePage.sortPosition);
		    expect(requests[0].method.toUpperCase()).to.equal("GET");
		    expect(requests[0].requestHeaders.Accept.toLowerCase()).to.contain("application/json");
		    expect(requests[0].async).to.be.true;
		}));

		it('executes onGetGenreJSON when request is successful', sinon.test(function() {
			var body = '{"id": 36,"poems_count": 10,"authors_count": 9,"show_page_title": "Gab","show_page_tagline": "Mostly Harmless"}';
			var spy1 = this.spy(genrePage, "onGetGenreJSON");
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };

		    genrePage.getGenreJSON();
		    requests[0].respond(200, { "Content-Type": "application/json" }, body);
		    expect(spy1).to.have.been.called;
		}));

		it('executes onError argument when request is unsuccessful', sinon.test(function() {
			var spy1 = this.spy();
			this.xhr = sinon.useFakeXMLHttpRequest();
		    var requests = this.requests = [];
		    this.xhr.onCreate = function (req) { requests.push(req); };

		    genrePage.getGenreJSON(spy1);
		    requests[0].respond(500, {}, "");
		    expect(spy1).to.have.been.called;
		}));

	});

	describe('#onGetGenreJSON', function() {

		beforeEach(function() {
			genrePage = new Genre();
			genreJSON = {
				"id": 36,
				"poems_count": 10,
				"authors_count": 9,
				"show_page_title": "Gab",
				"show_page_tagline": "Mostly Harmless"
			};
		});

		it("sets the page's showableGenre as a new ShowableGenre created using the supplied genreJSON", function() {
			var spy1 = sinon.spy(viewModelFactory, "ShowableGenre");
			genrePage.onGetGenreJSON(genreJSON);
			expect(spy1).to.have.been.calledWithNew.and.calledWith(genreJSON);
			expect(genrePage.showableGenre).to.be.an.instanceof(ShowableGenre);
			for(key in genreJSON) {
				expect(genrePage.showableGenre[key]).to.equal(genreJSON[key]);
			};
		});

		it('renders the showable genre cooresponding to the genreJSON', function() {
			genrePage.onGetGenreJSON(genreJSON);
			expect($("#poems_count")).to.contain.$html(genreJSON.poems_count);
			expect($("#authors_count")).to.contain.$html(genreJSON.authors_count);
			expect($("#page_title")).to.contain.$html(genreJSON.show_page_title);
			expect($("#page_tagline")).to.contain.$html(genreJSON.show_page_tagline);
			expect($("#poems_link")).to.have.$attr("href", "/genres/" + genreJSON.id + "/poems");
			expect($("#authors_link")).to.have.$attr("href", "/genres/" + genreJSON.id + "/authors");
		});

	});

	describe('#setEventListeners', function() {
		it('sets event listeners that call #onPreviousModelClick and #onNextModelClick on #previous_model and #next_model, respectively', sinon.test(function() {
			var spy1 = this.spy(genrePage, "onPreviousModelClick"), spy2 = this.spy(genrePage, "onNextModelClick");
			genrePage.setEventListeners();
			expect(spy1).to.not.have.been.called;
			expect(spy2).to.not.have.been.called;
			$("#previous_model").trigger("click");
			expect(spy1).to.have.been.calledOnce;
			$("#next_model").trigger("click");
			expect(spy2).to.have.been.calledOnce;
		}));
	});

});