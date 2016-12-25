(function() {

	"use strict";

	var pageFactory = modules.PoeticRivals.factories.page;

	pageFactory.Aqm = function() {

		var page = this;

		var generateColors = function() {
			var colorSets = [
				{"bkgrndclr":"#4169E1", "txtclr":"#FFFFFF"},
				{"bkgrndclr":"#436B95", "txtclr":"#FFFFFF"},
				{"bkgrndclr":"#66023C", "txtclr":"#B8860B"},
				{"bkgrndclr":"#CC9900", "txtclr":"#66023C"},
				{"bkgrndclr":"#006400", "txtclr":"#FFFFFF"},
				{"bkgrndclr":"#000000", "txtclr":"#FFFFFF"},
				{"bkgrndclr":"#ECDEC9", "txtclr":"#000000"},
				{"bkgrndclr":"#202020", "txtclr":"#9D9D9D"},
				{"bkgrndclr":"#9D9D9D", "txtclr":"#202020"},
				{"bkgrndclr":"#F8F8F8", "txtclr":"#5E5E5E"},
				{"bkgrndclr":"#5E5E5E", "txtclr":"#F8F8F8"},
				{"bkgrndclr":"#990033", "txtclr":"#CC9900"},
				{"bkgrndclr":"#90AFC5", "txtclr":"#763626"},
				{"bkgrndclr":"#763626", "txtclr":"#90AFC5"},
				{"bkgrndclr":"#2A3132", "txtclr":"#90AFC5"},
				{"bkgrndclr":"#90AFC5", "txtclr":"#2A3132"},
				{"bkgrndclr":"#C4DFE6", "txtclr":"#003B46"},
				{"bkgrndclr":"#003B46", "txtclr":"#C4DFE6"},
				{"bkgrndclr":"#07575B", "txtclr":"#66A5AD"},
				{"bkgrndclr":"#66A5AD", "txtclr":"#07575B"},
				{"bkgrndclr":"#07575B", "txtclr":"#C4DFE6"},
				{"bkgrndclr":"#C4DFE6", "txtclr":"#07575B"},
				{"bkgrndclr":"#055160", "txtclr":"#598234"},
				{"bkgrndclr":"#598234", "txtclr":"#055160"},
				{"bkgrndclr":"#AEBD38", "txtclr":"#68829E"},
				{"bkgrndclr":"#68829E", "txtclr":"#AEBD38"},
				{"bkgrndclr":"#333333", "txtclr":"#AFAFAF"},
				{"bkgrndclr":"#AFAFAF", "txtclr":"#333333"}
			];

			return colorSets[Math.floor(Math.random() * colorSets.length)];
		};

		var setColors = function(colors) {
			$("#aqm_quote_jumbotron").css({"background-color": colors.bkgrndclr, "color": colors.txtclr, transition: "all 0.5s ease-in-out"});
			$("#aqm_quote_block").css({"border-color": colors.txtclr, transition: "all 0.5s ease-in-out"});
			$("#aqm_quote_footer").css({"color": colors.txtclr, transition: "all 0.5s ease-in-out 0.5s"});
			$("#aqm_get_quote").css({"background-color": colors.txtclr, "border-color": colors.txtclr, "color": colors.bkgrndclr, transition: "all 0.5s ease-in-out"});
			$("#aqm_tweet_quote").css({"background-color": colors.txtclr, "border-color": colors.txtclr,"color": colors.bkgrndclr, transition: "all 0.5s ease-in-out"});
			$("#aqm_tweet_quote a").css({"color": colors.bkgrndclr, transition: "all 0.5s ease-in-out"});
			console.log(colors.bkgrndclr + " " + colors.txtclr);
		};

		var processQuote = function(quoteJSON, status, xhr) {
			$("#aqm_quote_edit").html('<i class="fa fa-quote-left"></i> ' + quoteJSON.quote + ' <i class="fa fa-quote-right"></i><br><br>');
			$("#aqm_quote_footer").html(quoteJSON.author);
			$("#aqm_tweet_link").attr("href", "https://twitter.com/intent/tweet?&text=" + quoteJSON.quote + " — " + quoteJSON.author);
		};

		var getQuote = function() {
			$.ajax(
				{
					url: "https://andruxnet-random-famous-quotes.p.mashape.com/",
					headers: {
					"X-Mashape-Key": "Qw2g12B4REmshcboj3CXywJddWW3p1Ghch3jsnkOe5kOLosA2s",
					"Content-Type": "application/x-www-form-urlencoded"
					},
					method: "POST",
					dataType: "json",
					success: page.processQuote,
					error: page.handleAjaxError
				}
			);
		};

		var handleAjaxError = function(error) {
			console.log(error);
		};

		var onGetQuoteClick = function() {
			$("#aqm_get_quote").on('click', function() {
				page.setColors(page.generateColors());
				page.getQuote();
			});
		};

		var setEventListeners = function() {
			$(document).ready(function() {
				page.onGetQuoteClick();
			});
		}

		page.generateColors = generateColors;
		page.setColors = setColors;
		page.processQuote = processQuote;
		page.getQuote = getQuote;
		page.handleAjaxError = handleAjaxError;
		page.onGetQuoteClick = onGetQuoteClick;
		page.setEventListeners = setEventListeners;

	}

})();