# frozen_string_literal: true

# Generator classes has to be copied to be able to use local template files
copy_file 'lib/generators/slim/controller/controller_generator.rb'
copy_file 'lib/generators/slim/scaffold/scaffold_generator.rb'

# Railtie methods overriding.
copy_file 'lib/generators/slim/railtie.rb'
directory 'lib/generators/slim/railtie'

# NOTE: Thor#directory interprets templates by default, which is not what we
#       want here
copy_file 'lib/templates/rails/scaffold_controller/controller.rb.tt'

copy_file 'lib/generators/slim/controller/templates/view.html.slim.tt'

copy_file 'lib/generators/slim/scaffold/templates/edit.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/_form.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/index.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/new.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/partial.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/show.html.slim.tt'

# These templates do not end in ".tt" and will not be interpreted, so we can use
# #directory
directory 'lib/templates/factory_bot'
directory 'lib/templates/rspec'

copy_file 'lib/templates/active_record/model/model.rb.tt'
