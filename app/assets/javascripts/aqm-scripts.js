function randomColors() {
    var colors = [
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
  var rndmNum = Math.floor(Math.random() * colors.length);
  $("#quoteJmbtrn").css({"background-color": colors[rndmNum].bkgrndclr, "color": colors[rndmNum].txtclr, transition: "all 0.5s ease-in-out"});
  $("#quoteBlock").css({"border-color": colors[rndmNum].txtclr, transition: "all 0.5s ease-in-out"});
  $("#quoteFtr").css({"color": colors[rndmNum].txtclr, transition: "all 0.5s ease-in-out 0.5s"});
  $("#getQuote").css({"background-color": colors[rndmNum].txtclr, "border-color": colors[rndmNum].txtclr, "color": colors[rndmNum].bkgrndclr, transition: "all 0.5s ease-in-out"});
  $("#tweetQuote").css({"background-color": colors[rndmNum].txtclr, "border-color": colors[rndmNum].txtclr,"color": colors[rndmNum].bkgrndclr, transition: "all 0.5s ease-in-out"});
  $("#tweetQuote a").css({"color": colors[rndmNum].bkgrndclr, transition: "all 0.5s ease-in-out"});
  console.log(colors[rndmNum].bkgrndclr + " " + colors[rndmNum].txtclr);
};

function processQuote(quoteJSON) {
  $("#quoteEdit").html('<i class="fa fa-quote-left"></i> ' + quoteJSON.quote + ' <i class="fa fa-quote-right"></i><br><br>');
  $("#quoteFtr").html(quoteJSON.author);
  $("#tweetLink").attr("href", "https://twitter.com/intent/tweet?&text=" + quoteJSON.quote + " — " + quoteJSON.author);
};

function getQuote() {
  $.ajax({
    url: "https://andruxnet-random-famous-quotes.p.mashape.com/",
    headers: {
      "X-Mashape-Key" : "Qw2g12B4REmshcboj3CXywJddWW3p1Ghch3jsnkOe5kOLosA2s",
      "Accept": "application/json"
    },
    method: "POST",
    dataType: "json",
    contentType: "application/x-www-form-urlencoded",
    success: function(result,status,xhr) {
      processQuote(result);
    }
  });
};

$("#getQuote").click( function() {
  randomColors();
  getQuote();
});