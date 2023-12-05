# Rails 7.1 quickstart Base Template

## Features

Rails will be installed with:

- RSpec as the test framework
- FactoryBot for test fixtures
- Slim as the view template language
- TailwindCSS as the CSS framework
- Propshaft for assets and Import Maps for JavaScript
- StimulusJS
- the Rubocop gem, with a decent configuration in `.rubocop.yml`
- Solargraph for intellisense

The application layout and the CRUD views generated via scaffolding will have a
theme and some other goodies already applied to them.

## Requirements

This templace assumes that **git** is installed and configured, and so does
Rails.

This template was created and tested with Ruby on Rails 7.1.2 and Ruby 3.2.2
with the Bundler 2.4.15, consider these the _recommended_ versions.

According to the Ruby on Rails gemspec file the **required** versions are:

- Ruby >= 2.7.0
- Ruby on Rails >= 1.8.11
- Bundler >= 1.15.0

You'll also need SQLite3 installed. The Rails Guide is not very clear on the
version, so I'll just quote them:

"Many popular UNIX-like OSes ship with an acceptable version of SQLite3. Others
can find installation instructions at the [SQLite3
website](https://www.sqlite.org/)"

## Installation

### Ruby, SQLite3 and Rails

If you are new to Ruby or Rails, you can start by following the
[Getting Started with Rails](https://guides.rubyonrails.org/v7.1/getting_started.html)
guide for 7.1 up to and **excluding**
[3.2 Creating the Blog Application](https://guides.rubyonrails.org/v7.1/getting_started.html#creating-the-blog-application).

### Download the .railsrc file

Part of the quickstart's job is to create a new Rails application with predefined options right from the start.
One way to do this is to download the [\_railsrc](./_railsrc) file from this
repository, rename it to `.railsrc` and copying it to your home directory.

One way to do it would be with cURL:

```bash
curl  -o ~/.railsrc https://raw.githubusercontent.com/riccardo-giomi/rails-7.1-quickstart/master/templates/base/_railsrc
```

As always with these kind of files, you should have a look before using it, and
see that there are no shenenigans. Also please remember to remove the file when
it's not needed or wanted anymore.

Note: comments in the .railsrc file seem to not behave correctly on the current
Rails version, so the current `_railsrc` file does not have any.

### Rails new away

As long as the quickstart's `.railsrc` file is available, running `rails new <app>`
will create the new application using this quickstart's features.

Note that the files required by the template will be downloaded to you machine's
temporary directory while creating the application, in a directory called
`rails-7.1-quickstart` and deleted at the end of the process.

### After the installation

#### Check the pre-generated license file

The template will create a MIT-LICENSE file, trying to get the users' names from
their `git config user.name`. After installation you should check if the name is
present and correct, and edit it as required.
