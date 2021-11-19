# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
	3.0.2

* System dependencies
	- sqlite3
	- yarn
	- haml
	- jquery
	- font-awesome-rails

* Configuration

	1. Execute `bundle install` in project directory
	2. Execute `yarn install` to make sure packages is install to project

* Database creation

	1. Execute `bin/rails db:create` 
	2. Execute `bin/rails db:migrate`
	3. You are good to go!

* Database initialization

	This is a testing project and nothing about privacy, use the default database.yml will do!

* Show deleted articles and comments(Tasks 3)

	Please follow the instructions to get the deleted articles and comments in rails console.
	
	1. Execute `bin/rails console` in project directory
	2. Execute `Article.deleted`
	3. Execute `Comment.deleted`
	4.  
* Explore the Website

	Execute `bin/rails start` in project directory and browse **localhost:3000**
