# frozen_string_literal: true

# Remove causes of Documentation/Style errors from Rubocop.
insert_into_file 'app/models/application_record.rb',
                 "# :nodoc:\n",
                 before: 'class ApplicationRecord < ActiveRecord::Base'

insert_into_file 'app/controllers/application_controller.rb',
                 "# :nodoc:\n",
                 before: 'class ApplicationController < ActionController::Base'

insert_into_file 'app/mailers/application_mailer.rb',
                 "# :nodoc:\n",
                 before: 'class ApplicationMailer < ActionMailer::Base'

copy_file 'app/assets/stylesheets/application.tailwind.css', force: true
copy_file 'app/javascript/controllers/dialog_controller.js'
copy_file 'app/helpers/application_helper.rb', force: true
copy_file 'app/views/layouts/application.html.slim'
remove_file 'app/views/layouts/application.html.erb'

copy_file 'app/views/application/_delete_button_with_dialog.html.slim'
copy_file 'app/views/application/_notifications.html.slim'
