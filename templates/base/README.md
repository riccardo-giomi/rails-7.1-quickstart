# Rails 7.1 quickstart Base Template

This a custom [Ruby on Rails
template](https://guides.rubyonrails.org/rails_application_templates.html) that
provides a custum configuration and additional features on top of [Rails'
scaffolding](https://www.rubyguides.com/2020/03/rails-scaffolding/).

## Quickstart's... quick start

For those that would like to give it a spin and have a look a the result, here
are the quick instructions that will also create an Example model with all the
fun stuff.

1. the installation file is [here](./_railsrc), save locally as `~/.railsrc`
2. `rails new <app name>`
2. `cd <app name>/`
3. `bin/rails db:create db:migrate` 
4. 
``` bash
bin/rails generate scaffold ExampleRecord title:title abstract:abstract datetime:datetime date:date time:time image:image images:images file:attachment files:attachments boolean:boolean
```
5. `bin/rails db:migrate` 
6. `bin/dev`

The scaffolding results should be available at the usual `http://localhost:3000/example_records` URL.

## Features

### Pre-compiled MIT license file

A minor thing that I always forget... so it will be generated on installation,
and pre-compiled with the current year and your Github email name and address.

### Gems and application configuration

Rails will be installed with **Propshaft** with **Import Maps** as the static
JavaScript asset pipeline.

The following gems are installed and configured at least to a basic level:

#### Test Framework

- [RSpec](https://rspec.info/) replacing mini_test as teh test framework
- [FactoryBot](https://github.com/thoughtbot/factory_bot) for test fixtures

#### Front-end
- [Slim](https://slim-template.github.io/) replaces ERB as the template language
- [TailwindCSS](https://tailwindcss.com/) as the CSS framework
- [StimulusJS](https://stimulus.hotwired.dev/) as the JavaScript framework

#### Attachments support (ActiveStorage)

- **image_processing** and **ruby-vips** for, well... image processing
- [Active Storage Validations](https://github.com/igorkasyanchuk/active_storage_validations)

#### Linting and intellisense

- [Rubocop](https://rubocop.org/) for code style checking; this includes:
  - rules for rails, performance and RSpec
  - a custom starting configuration for `.rubocop.yml`
- [Solargraph](https://solargraph.org/) for intellisense support

### Additional field types for the scaffold generator

This template adds new field types that can be used with the
`rails generate scaffold` command: these types will ultimately map to an
original ones but will have additional behaviour or presentation somewhere.

Note: these special types will exist only until the generator task ends, there
is no support for them inside the generated code.

Some of the default types will also be treated differently.

#### :title

New type, same as `:string`, except:

1. It will always be considered required when generating migrations and
   validations
2. It will be the first field shown in the appropriate views, will have a
   distinct style and will be a link to the corresponding _show_ where it makes
   sense
3. Only one field of this type is expected, any extra :title field should be
   treated like a normal :string field in most places
4. The generated specs will test that the field is indeed required.

#### :abstract

New type, same as `:text`, except:

1. It will be the second field shown in the appropriate views if a :title field
   is also present, otherwise it will be the first one
2. It will have a distinct "abstract-y" style
2. Only one field of this type is expected, any extra :abstract field should be
   treated like a normal :text field 

#### :attachment and :attachments

Pre-existing types for Rails' ActiveStorage attachments, now with additional
behaviour:

1. A Front-end presentation as part of this template's theme.
2. Simple attachment handling in forms (no JavaScript fancy stuff) to add,
   remove and replace attachments
3. Example (commented out) validation and spec code for common file constraints,
   where appropriate

Note: To make deleting attachments from a form possible the generated controller
will handle parameters from non-JSON requests a bit differently from how Rails
usually does it.

#### :image and :images

New type, same as `:attachment` or `:attachments`, except:

1. Model code will include basic validations for images, and commented out
   examples on how to expand on those
2. Model code will also have a couple of sensible variants already defined
3. The Front-end presents these fields appropriately, with the possibility to
   click on the image to get a gull-size modal where applicable
4. Forms will have the same features as per `:attachment` and `:attachments`
   above
5. Generated specs will already include tests for the additional validations and
   variants.

The variants defined for images are `:gallery` (resized to 300x300) and `:thumb`
(100x100). The last one is not used anywhere for the moment.

Note: same as attachment fields, the generated controller will handle parameters
a bit differently than usual.

#### :boolean

Pre-existing type, the only behaviour change is that the migration will have a
`default: false` option for this field.

### HTML theme

Views generated with scaffolding will have a basic and simple theme already
applied to them. There is a light and dark version of the theme, according to
the browser settings.

The theme was created using [TailwindCSS](https://tailwindcss.com/), and the SVG
icons taken from [heroicons.com](https://heroicons.com/).

The theme itself is still a work-in-progress. It is a (quite messy) mix of
general styles in `app/assets/stylesheets/application.tailwind.css` and
TailwindCSS classes in the HTML code.

All view templates and partials are written with
[Slim](https://slim-template.github.io/).

The confirmation dialogs and full-size image modals are controlled with
[StimulusJS](https://stimulus.hotwired.dev/).

Common or repeatable code is generally handled in partials, with helper support
where needed.

At the moment there is no support for paging or appear-on-scroll behaviours for
the index view, nor anything for the starting (:root) page (or any static page,
really).

### Generated specs and factories

The template will install a minimal smoke test to see if Rails, RSpec and
Factory bot where installed correctly in `spec/smoke_tests_spec.rb`. 

The scaffold generator will create modified versions of factories and specs
related to the model.

Specs should work out of the box thanks to the pre-prepared factory values.

For example models defined with a `:image` or `:images` field will have fixture
images in their factory where appropriate, and specs will already include checks
for variants and constraints.

The fixture files (a PDF and an image) provided with the template can be found
in `spec/fixtures/files/`.

The template also adds some custom matchers to the applications in
`spec/support/matchers/`.

### Extra goodies

#### Rubocop auto-run

Rubocop will be auto-run with the autocorrect option at the end of `bin/rails new` and every time a new scaffold is generated.

## Requirements

This template assumes that **git** is installed and configured, and so does
Rails.

This template was created and tested with Ruby on Rails 7.1.3 and Ruby 3.2.2
with Bundler 2.4.15, consider these the _recommended_ versions.

According to the Ruby on Rails gemspec file the **required** versions are:

- Ruby >= 2.7.0
- Ruby on Rails >= 1.8.11
- Bundler >= 1.15.0

You'll also need SQLite3 installed. The Rails Guide is not very clear on the
version, so I'll just quote them:

"Many popular UNIX-like OSes ship with an acceptable version of SQLite3. Others
can find installation instructions at the
[SQLite3 website](https://www.sqlite.org/)"

Lastly, if you are using the `:image` and `:images` fields when scaffolding,
`libvips` will be required to generate their variants.
See [here](https://github.com/libvips/ruby-vips) for more information.

## Installation

### Ruby, SQLite3 and Rails

If you are new to Ruby or Rails, you can start by following the
[Getting Started with Rails](https://guides.rubyonrails.org/v7.1/getting_started.html)
guide for 7.1 up to and **excluding**
[3.2 Creating the Blog Application](https://guides.rubyonrails.org/v7.1/getting_started.html#creating-the-blog-application).

As already mentioned, to support image variants and image processing in general, `libvips` will need to be installed.
[The ruby-vips repository](https://github.com/libvips/ruby-vips) has instructions on how to do it.

### Download the .railsrc file

Part of the quickstart's job is to create a new Rails application with predefined options right from the start.

You'll need to create or edit a file called `.railsrc` in your home directory
with the content from the [\_railsrc](./_railsrc) file in this repository.

Copy-and-paste in an editor would do, of course, but cURL would also work to replace it, e.g.:

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

### Set up the database

From the new app's directory, run `bin/rails db:create db:migrate`.

### After the installation

#### Check the pre-generated license file

The template will create a MIT-LICENSE file, trying to get the users' names from
their `git config user.name`. After installation you should check if the name is
present and correct, and edit it as required.

#### Run the specs

There's not much, but running `bundle exec rspec` in the new app's directory
will check that at least RSpec and Factory Bot work.

#### Generate a scaffold

The following example command generates an ExampleRecord model with all of the goodies mentioned:

``` bash
bin/rails generate scaffold ExampleRecord title:title abstract:abstract datetime:datetime date:date time:time image:image images:images file:attachment files:attachments boolean:boolean
```

#### Create the DB table for the new Model and run the specs again

```bash
bin/rails db:migrate
bundle exec rspec --format d
```

The "format as documentation" option is not really required, but it looks
cooler... and should give you an idea of what RSpec examples where created.

#### Start the server and have a look

Start the server with the `bin/dev` command, the scaffolded pages should be available at `http://localhost:3000/example_records`.
