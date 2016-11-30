# Poetic Rivals

`Poetic Rivals` is a competitive poetry platform built on `Ruby on Rails`.

## Installation

This web app can be installed by cloning the GitHub [repository](https://github.com/lair001/poetic-rivals) to your system.  You may also host it live on your own server or a hosting service such as [Heroku](https://www.heroku.com/) or [Amazon Web Services](https://aws.amazon.com/).

## Usage

If you have cloned the GitHub repository to your system, you can start the app by navigating to the directory containing the repository and running `rails s`.  You can then view the web app's homepage by navigation to http://localhost:3000 in your browser of choice.

### Signing Up and Logging In

You may sign up or login by following links at the bottom of the homepage.

### Navbar

The left side of the navbar includes a `Navigation` dropdown menu that contains links to the top and bottom of a page along with a genres listing.  There is a button linking to the `Leaderboard` next to the `Navigation` dropdown.

The right side of the navbar includes a field to perform a Google Search. It will have a `Create` button and an `Account` dropdown menu if you are logged in.  The `Create`button will take you to a form to post a new commentary if you are on a commentary listing.  Otherwise, it will take you to a form to create a new poem.  The `Account` dropdown includes links to your profile, to edit your account information, and to log out.

### Poem Listing

Poem listings exist in the context of either a user or a genre.  In either case, there are links to the poem show pages consisting of the poem's title.  There are also links to poem genres.

### Poem Show Page

This page includes a poem's title, author, and body.  If you have not voted on the poem and are not its author, then there are buttons to vote on the poem.  If you previously voted on the poem, there is a button to delete your vote.  If you are the author of the poem or a moderator, there is a button to delete it.  There is also a link to commentary regarding the poem.

### Commentary Listing

This page lists all commentary regarding a poem.  Each listing includes information about the commentator along with the comment.  The poem title and author are identified at the top of the page.  There are buttons to add a commentary.  You may edit or delete a commentary if you are the commentator or a moderator.

### Leaderboard

The leaderboard includes a dashboard which reports the users with the highest and lowest scores, most fans, most idols, most rivals, and most victims.  After the dashboard is a listing of users ordered by score.  Clicking on a username will take you to a profile page for the user.

### User Profile

The top of a user's profile includes username, role, when the user joined, email address, genres, score, score per poem, fans count, idols count, rivals count, and victims count.  If you are a moderator, there will be a button to ban or unban the user.  If you are viewing your own profile or if you are an administrator, there will be a button to edit the user's account information.

The bottom of the profile page includes a link to a list of the user's poems along with buttons to idolize or victimize a user.  If you are already idolizing or victimizing a user, these buttons will be replaced by a button to delete the relationship.

### Creating Administrators and Moderators

For security reasons, it is only possible to set adminstrator and moderator permissions through `rails console` or a database editor.  To do it with `rails console`, navigate to the directory where the respository is cloned and run `rails c`.  This takes you to rails console's command line.  

To set moderator permissions, run `ForumUser.find_by(username: "[username]").update(role: "moderator")`.  To remove moderator permissions, run `ForumUser.find_by(username: "[username]").update(role: "poet")`.

To set administrator permissions, run `ForumUser.find_by(username: "[username]").update(role: "administrator")`.  To remove moderator permissions, run `ForumUser.find_by(username: "[username]").update(role: "poet")`.

For example, `ForumUser.find_by(username: "The One").update(role: "moderator")`will grant moderator permissions to the user whose username is `The One`.

You may exit the `rails console` command line by running `exit`.

### Easter Eggs

If you click the navbar brand, you will be taken to the `Amazing Quote Machine`.  Clicking on the navbar brand again will take you to the homepage.

## Contributing

If you want to contribute, feel free to fork the `poetic-rivals`repository and submit a pull request.  You may also email Samuel Lair at lair002@gmail.com.

## License

This gem is open source under the [MIT license](https://github.com/lair001/poetic-rivals/blob/master/LICENSE).