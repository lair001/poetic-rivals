# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
	You can toggle through genre show pages using previous and next buttons.  These buttons make an AJAX get request and render the data on the existing DOM.
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
	The leaderboard, genre authors, genre poems, and user poems render additional resources on the page through a scroll event.  The user poem commentaries page renders additional resources through a click event bound to a more comments button.
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
	The genre authors, genre poems, user poems and user poem commentaries all render a has_many relationship in JSON and appends the information in the JSON to the DOM.
- [x] Include at least one link that loads or updates a resource without reloading the page.
	The user poem commentaries page appends additional commentaries to the DOM by clicking a more commentaries button.  You can also submit an new commentary by a form.  If the record is successfully created, it will be appended to the DOM.
- [x] Translate JSON responses into js model objects.
	The viewModel constructors create viewModel objects by appending properties from a JSON and adding at least one additional function.  For example, all viewModels have a #render method.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
	See previous question.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
