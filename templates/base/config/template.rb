# frozen_string_literal: true

# Let RuboCop autocorrect files from generators:
# https://github.com/rubocop/rubocop-rails#rails-configuration-tip
environment <<-'RUBY', env: 'development'
  # Let RuboCop autocorrect files from generators:
  # https://github.com/rubocop/rubocop-rails#rails-configuration-tip
  config.generators.after_generate do |files|
    puts <<-INFO # rubocop:disable Rails/Output

      Running RuboCop autocorrection.
      Run "rubocop" again, possibly with the "--auto-gen-config" option, to see if it missed something.
    INFO
    parsable_files = files.filter { |file| file.end_with?('.rb', '.jbuilder') }
    system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin} > /dev/null || true", exception: true)
  end

RUBY
