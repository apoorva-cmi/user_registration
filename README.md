# README

Run the following commands to setup the application:

1. git clone git@github.com:apoorva-cmi/user_registration.git

2. bundle install

3. rails db:setup

4. rails s

### Steps

* The port for the application is 3000. Hence, on opening *http://localhost:3000/*, a welcome screen shows up, with links to __Sign Up or Login__.

* On clicking __Sign Up__, email and password are requested to setup an account.

* A successful __registration email__ is received if the Sign Up is successful.

* __Login__ to enter into the account.

* There are __Edit and Logout__ options on the profile screen. Edit shows the functionality to reset password and modify the Username.

* __Forgot Password__ functionality is present as well to reset the password, on the Login page. Enter the email-id to receive the reset-password instructions.

### System dependencies:

- Ruby version 2.3.1
- Rails version 5.1.7
- Rspec
- Postgres
- Letteropener
- Bundler version 2.0.1
