# Ad Signal tech test

For this test, we'd like you to spend a couple hours improving a toy contact
management app we created.

Ensure that you can run the app on your system and acquaint yourself with it
before implementing the user stories below.

To submit your test, please open a Pull Request (or more) for us to review.

# Non-functional requirements

## Documentation and Git usage

Please ensure that your Git history is tidy - we would like to review your Pull
Requests commit by commit. Feel free to use commit messages to document any
design decisions you make and/or use the Pull Request to provide clarifications
you feel are warranted, whether they are technical or design-related or
anything else.

## Tests

As an engineering team, we want to ensure that our codebases have good test
coverage so that we have robust and error-free applications.

We use RSpec (which is already in the codebase now), and would love to carry on
using it here. If you prefer to use minitest or any other framework, feel free
to make that switch and let us know why you prefer. 

Feel free to add any other supporting gems to rspec which will support you
further in testing if needed.

# User stories

## Story 1

As part of the requirements for our application, we need to facilitate a
collection of contacts where contacts can be assigned to teams.

As a user, I want to add contacts to a team and see the existing contacts of a
team.

### AC

- Contacts are described as follows
    * first_name (required, 255 characters)
    * middle_name (255 characters)
    * last_name (required, 255 characters)
    
    (Either or both of the following are required:)

    * email (unique (case insensitive) and must validate as an email address)
    * phone_number (starts with the UK country code (+44 or 0044) then 11 digits)

- The list / table of contacts should live in the team show page with columns
  for contact full name, email and options/links to show, edit and destroy a
  contact.

- Team show must have a button/link to navigate to create new contact within
  that team.

- Contact form must include an input for all the columns.

- The designs for the list/table view, show page and contact form should follow
  similar patterns used for organisation and teams.

- Contact show page must include all relevant details of the user.

- There is a breadcrumb trail on all the page described above, allowing me to
  navigate quickly through the hierarchy.

## Story 2

As a user I want to copy a contact's email to my clipboard, so that I can
efficiently copy the relevant information on this page.

### AC

- There is an icon link next to the email on contact show page for copying
  email to clipboard.

- Clicking on the icon link will copy the email to my clipboard and display
  some feedback to the user on the page that the email has been copied.

## Story 3

As a user, when I add a Contact to a team or more, at the end of the day I want
to notify them, through their available contact options, that they are now part
of more teams.

⚠️ _To ensure actual people are not notified in error, please use null or fake
mailers/texters for this story. We are happy for you to only test that the
interfaces are called correctly._ ⚠️

### AC

- Only notify Contacts that were indeed added to any team(s) that day.
- All eligible Contacts are to be notified on a fixed schedule of your
  choosing.
- If the Contact has a phone number, use it to send a text notification.
- If the Contact has an email address, use it to send an email notification.
- The text notification says "You've been added to %{count} teams".
- The email notification lists the names of all the teams they were added on
  the preceding day only.

# Optional stories

## Optional story 1

As a platform engineer, I want to add docker and compose file to allow a user
to run the application inside a containerised environment and a helm file that
would allow the application to be run on a Kubernetes cluster.

### AC

- Add a Docker and compose file that allows a user to run the application
  inside a containerised environment

- Add a Helm file that would allow the application to be run on a Kubernetes
  cluster

## Optional story 2

As engineering team we want our tests to run on Github Actions so that we can
feel confident that we don't have any tests failing with new features and pull
requests.

### AC

- Have our RSpec test running as a job on our Github actions main workflow
  right after lint passes.
