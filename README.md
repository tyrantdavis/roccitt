## Roccitt: inspired by Reddit and built on Rails.

[Demo Site](https://roccitt.herokuapp.com)

## Objectives

A user can sign up, create posts, comment on posts, vote on posts, favorite posts and receive updates on their favorite posts via email.

## User Stories

- Users can sign up for a free account by providing a user name, password and email
- Users can sign in and out of Roccitt
- Users can view topics and posts
- Users can comment on posts
- Users can create new posts and edit posts they own
- Users can up/down vote any post
- Users can favorite any post and receive email update notifications
- User's profile displays user's posts and comments
- Users can add a Gravatar to their profile
- User roles available: admin or member user
- Admins can delete and create any topic or post
- Development database is seeded automatically with users, topics, posts, comments, favorites, and votes

## Build Tools

#### Languages and Frameworks:

- Ruby version: 2.5.1
- Rails 5.2.3
- Bootstrap

#### Database:

- PostgreSQL (Development)
- PostgreSQL (Production)

#### Gems:

- BCrypt - secure passwords
- SendGrid - email confirmation
- FactoryBot - defining and using factories

## Setup and Configuration

#### To run Roccitt locally:

CAUTION: DO NOT enter the **\$**. It merely indicates that the subsequent command should be executed at the command line.

1. Clone the repository
2. `$ cd` into the local repository
3. Run `$ bundle install`
4. Create and migrate the database with `$ rake db:create` and `$ rake db:migrate`. NOTE: `$ rails db:create` and `$ rails db:migrate` will work as well.
5. Start the server using `$ rails server`
6. Run the app on `$ localhost:3000`
