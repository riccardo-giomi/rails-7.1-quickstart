# frozen_string_literal: true

# Generator classes had to be copied to be able to use local template files.
copy_file 'lib/generators/slim/controller/controller_generator.rb'
copy_file 'lib/generators/slim/scaffold/scaffold_generator.rb'
# NOTE: Thor#directory interprets templates by default, which is not what we
#       want here.
copy_file 'lib/generators/slim/controller/templates/view.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/edit.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/_form.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/index.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/new.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/partial.html.slim.tt'
copy_file 'lib/generators/slim/scaffold/templates/show.html.slim.tt'
