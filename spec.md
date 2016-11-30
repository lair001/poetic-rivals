# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project

v 5.x

- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)

The project includes multiple instances of has many, has many through, and belongs to relationships.  There are nearly 30 declared associations in the project.

- [X] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
- [X] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)

- [X] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)

E.g. a user has many genres through poems through poem_genres. A user can submit genre names in a nested form that is part of the new/edit poem form.

Poems themselves join users/authors with commentaries and commentaries join users/authors with commentators.  Poems having a title and body and commentaries having a comment.

- [X] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)

Numerous validations.  For instance, a user may only up/downvote a poem once and can only have one fandom/rivalry with a given user.

- [X] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

Leaderboard includes users with the most fans, idols, rivals, and victims along with the users with the highest and lowest scores.

- [X] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)

E.g. a user has many genres through poems through poem_genres. A user can submit genre names in a nested form that is part of the new/edit poem form.

- [X] Include signup (how e.g. Devise)

Devise.

- [X] Include login (how e.g. Devise)

Devise.

- [X] Include logout (how e.g. Devise)

Devise.

- [X] Include third party signup/login (how e.g. Devise/OmniAuth)

Devise with OmniAuth for Amazon, Facebook, Github, and Google.

- [X] Include nested resource show or index (URL e.g. users/2/recipes)

Poem index and show pages nested under users. Commentaries index nested under user poem.

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)

New/edit poem form nested under user.  New/edit commentary form nested under user poem.

- [X] Include form display of validation errors (form URL e.g. /recipes/new)

Errors for forms with fields show validation errors on the form and style the fields with errors.  Errors for forms that consist of only a button manifest as flash messages.

Confirm:
- [X] The application is pretty DRY
- [X] Limited logic in controllers
- [X] Views use helper methods if appropriate
- [X] Views use partials if appropriate
