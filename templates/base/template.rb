# frozen_string_literal: true

add_template_repository_to_source_path

gem_group :development, :test do
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'

  gem 'rubocop',             require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails',       require: false
  gem 'rubocop-rspec',       require: false

  gem 'slim-rails'

  gem 'solargraph'
  gem 'solargraph-rails'
end

after_bundle do # rubocop:disable Metrics/BlockLength
  copy_file '.rubocop.yml'
  copy_file '.rubocop_todo.yml'
  copy_file 'solargraph_helper.rb'

  copy_file '.gitignore', force: true
  copy_file '.rspec'
  directory 'spec'

  apply 'app/template.rb'
  apply 'config/template.rb'
  apply 'lib/template.rb'

  template 'MIT-LICENSE'

  say('Installing gems for pagination support')
  gem 'pagy', '~> 8.2'

  say("\nSetting up ActiveStorage...", :yellow)
  rails_command 'active_storage:install '

  say('Installing gems for ActiveStorage validations and processing')

  gem 'active_storage_validations'
  gem 'image_processing'
  gem 'ruby-vips'

  say('... done.', :yellow)
  say(<<~SAY, :yellow)
    You might also want to check the system requirements at https://guides.rubyonrails.org/v7.1/active_storage_overview.html#requirements.
  SAY

  say(<<~SAY, :yellow)

    Running Rubocop with auto-fix on all the initial files
  SAY

  # Let RuboCop fix the initial files.
  run 'bundle exec rubocop -A --fail-level A > /dev/null || true'
end

# Dear Rubocop, I like my definitions at the end.
# rubocop:disable Style/BeginBlock
BEGIN {
  # Shamelessly but respectfully borrowed from
  # https://github.com/mattbrictson/rails-template
  #
  # Add this template directory to source_paths so that Thor actions like
  # copy_file and template resolve against our source files. If this file was
  # invoked remotely via HTTP, that means the files are not present locally.
  # In that case, use `git clone` to download them to a local temporary dir.
  def add_template_repository_to_source_path
    path = __FILE__.match?(%r{\Ahttps?://}) ? download_repository : File.dirname(__FILE__)

    source_paths.unshift(path)
  end

  def download_repository
    require 'tmpdir'
    tmp = Dir.mktmpdir('rails-7.1-quickstart')
    at_exit { FileUtils.remove_entry(tmp) }
    git clone: "--quiet --depth 1 https://github.com/riccardo-giomi/rails-7.1-quickstart.git #{tmp}"

    File.join(tmp, 'templates/base')
  end
}
# rubocop:enable Style/BeginBlock
