# Ad Signal UX test

For this test, we'd like you to review a pull request a developer has created.

# Set up the system

## ⚡️ System Dependencies

This project expects you to have the following available on your system:

* [Ruby](https://www.ruby-lang.org/)
* [Node.js 14](https://nodejs.org/download/release/latest-v14.x/)
* [Docker](https://www.docker.com/products/docker-desktop)

Along with Ruby, the following are required to maintain application
dependencies:

* [Bundler](https://bundler.io/)
* [Yarn](https://yarnpkg.com/)

## 🎲 Installation

Once you have set up the dependencies, follow these steps:

```sh
# Install bundler and yarn if you don't have them...
gem install bundler
npm install -g yarn

# Clone the project
git clone git@github.com:ad-signalio/take-home-qa-test.git
cd take-home-qa-test
```

Obtain the application dependencies using bundler

```sh
bin/bundle install
bin/yarn install
```

Create and setup the database and start mailcatcher:

```sh
docker-compose up
bin/bundle exec rails db:prepare
```

This will start Mailcatcher at http://localhost:1080/, which you can use to
intercept and inspect the emails sent by the application.

It will also start a PostgreSQL server, set up the database and generate a test
user with the following credentials:

- email: test-user@test.co.uk
- password = 123Password!
- first_name: Test
- last_name: User

### 🐳 Using Docker

Docker takes care of running the postgresql and mailcatcher services required
for the application to function.

## Getting up and running

After starting docker, we need to start the rails server locally.

```sh
bin/bundle exec rails server
```

# Test

This test incorporates a create account feature where the user is able to create
an account using their email address. There is a dummy story with acceptance
criteria.

As part of this test, we would like you to take a look at this feature that has
been in.

As part of the QA test, we would like you to have a look at the acceptance
criteria and come up with some additional acceptance criteria that you think
would be needed.

Test the feature and try to catch bugs and write a bug report as you would to
raise the issue.

Finally take a look at the automated test to highlight what are missing and what
you feel should be added.

# User story

## User self registration

**As A New user**
**I want to be able to signup as a user**
**So I can log in**

### Acceptance Criteria

- User is displayed with the Create Account button
- Selecting the create account button takes the user to Page 1 of self-registration

#### Page 1:

- User is displayed with a first name field (255 characters, presence required)
- User is displayed with the last name field (255 characters, presence required)
- The email address field must be in a valid format. (use Devise's built-in email
  regex)
- The email address must be unique
- The password must be at least 8 characters
- The user must confirm their password
- The user gets a confirmation email

#### Page 2:

- User is displayed with Job title field (255 characters, optional)
- User is displayed with Phone number field (15 characters, format:[0-9+\s] number
  "+" and space, optional)
- User is displayed with Organisation name (255 characters, presence required)
- User must agree to T&Cs
- Users can opt to receive newsletters and marketing updates.

