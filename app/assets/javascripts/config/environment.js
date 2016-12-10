var poeticRivals = {}; // namespace for application scripts

tabOverride.set(document.getElementsByTagName('textarea')); // applying tabOverride to all textarea inputs

//attempting to fix a bug with Bootstrap dropdowns where they stop working after the user follows a link in the dropdowns
$(document).ready(function() {
    $(".dropdown-toggle").dropdown();
});