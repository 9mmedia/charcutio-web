# Charcutio Web

## Installation

1. `git clone git://github.com:9mmedia/charcutio-web.git` to desired project directory
2. Use latest patched Ruby 2.0.0 using [ruby-build](https://github.com/sstephenson/ruby-build) and [rbenv](https://github.com/sstephenson/rbenv). If you just did a fresh Ruby install run the following commands:

        gem update --system
        gem update
        gem install bundler rake foreman rails mailcatcher --no-rdoc --no-ri

3. Create Heroku account, [install Toolbelt and login using heroku CLI](https://devcenter.heroku.com/articles/quickstart#step-2-install-the-heroku-toolbelt)
4. Set a Heroku git remote. You can name it something else but examples in other sections will use `heroku` as the remote name.

        git remote add heroku git@heroku.com:charcutio-web.git

5. Install [Homebrew](http://brew.sh/)
6. `brew update`
7. `brew install postgresql`
8. Follow any post installation instructions given by Homebrew
9. Move `/usr/local/bin` so our PostgreSQL install is used over the system install (OSX) and reload the current bash session since we updated the PATH variable.

        echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
        source ~/.bash_profile

10. `gem uninstall pg` since if previously installed, gem might continue to [use the wrong PostgreSQL installation](http://tammersaleh.com/posts/installing-postgresql-for-rails-3-1-on-lion)
11. `bundle install`
12. `createuser -d -r -S charcutio`
13. `createdb -O charcutio charcutio_development`
14. `createdb -O charcutio charcutio_test`
15. `bundle exec rake db:migrate`
16. `bundle exec rake db:test:prepare`
17. `foreman start` to start the server

## Run Tests

1. Start the server to run tests using `foreman start`
2. Server side tests use MiniTest (Rails 4 default)

    bundle exec rake test

3. Client side tests use QUnit through [qunit-rails gem](https://github.com/frodsan/qunit-rails). Go to [http://localhost:5000/qunit](http://localhost:5000/qunit) to see and run the QUnit Test Runner.

## Data API

Simple implementation to get started with data pushing.

Create a new box, returns box id.

    POST /boxes {"api_key": "API_KEY", "name": "Box Name"}

Report data point

    POST /boxes/:id/report {"api_key": "API_KEY", "type": "temp", "value": 55.6}

Get temperature/humidity set points

    GET /boxes/:id/set_points {"api_key": "API_KEY"}

Tweet a photo.

    POST /boxes/:id/photo {"api_key": "API_KEY", "image_file": multipart_file}
