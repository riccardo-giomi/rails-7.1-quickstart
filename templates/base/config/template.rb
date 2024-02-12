# frozen_string_literal: true

environment <<-'RUBY', env: 'development'
  config.generators do |g|
    g.factory_bot suffix: 'factory'

    # Let RuboCop autocorrect files from generators:
    # https://github.com/rubocop/rubocop-rails#rails-configuration-tip
    g.after_generate do |files|
      puts <<-INFO # rubocop:disable Rails/Output

        Running RuboCop autocorrection.
        Run "rubocop" again, possibly with the "--auto-gen-config" option, to see if it missed something.
      INFO
      parsable_files = files.filter { |file| file.end_with?('.rb', '.jbuilder') }
      system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin} > /dev/null || true", exception: true)
    end
  end

RUBY

insert_into_file 'config/application.rb', <<~RUBY, after: 'Bundler.require(*Rails.groups)'

  # Custom, local railtie to add extra functionalities to the slim-rails
  # generators.
  require File.expand_path('../lib/generators/slim/railtie', __dir__)
RUBY

copy_file 'config/locales/en.yml', force: true
