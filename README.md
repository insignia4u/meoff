= meoff
=====

Simple team communication tool aimed to keep everybody on the loop on who's gonna be out.

== Dependencies

  Ruby 2.0.0 (path level 150 or higher)
  Rails 4.0.0
  SQLite3
  Puma

== Bootstrap

Just run bundle install and you should be good to go.

This application uses Figaro for setting the environment variables, so your environment should have a config/application.yml file which will include the env variables needed. You can follow config/application.yml.sample as an example.

Don't forget to specify your own config/database.yml file. You can follow config/database.yml.sample as a guide.

== Testing

Rspec 2 testing stack with capybara support.