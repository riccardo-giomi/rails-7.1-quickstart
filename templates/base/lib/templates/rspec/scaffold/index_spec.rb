# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/index' do
  let(:<%= ns_table_name %>) { create_list(:complete_<%= singular_table_name %>, 2) }

  before { assign(:<%= ns_table_name %>, <%= ns_table_name %>) }

  it 'renders a list of <%= ns_table_name %>' do
    render

    <%= ns_table_name %>.each do |<%= singular_table_name %>|
      assert_select "#<%= plural_table_name %> div##{dom_id <%= singular_table_name %>}" do
<%
for attribute in attributes
  if attribute.attachment? || attribute.attachments?
    if attribute.extended_type.in?([:image, :images])
      expected_tag       = 'div img[alt=?]'
      expected_extension = 'jpg'
    else
      expected_tag = 'div a[target=_blank][alt=?]'
      expected_extension = 'pdf'
    end
    # Check templates/factory_bot/model/factories to see where these come from:
    file_index        = attribute.attachments? ? '_1' : ''
    expected_filename = "#{singular_table_name}_#{attribute.name}#{file_index}.#{expected_extension}"
-%>
        assert_select '<%= expected_tag %>', '<%= expected_filename %>'
<%
  elsif attribute.type == :boolean
    # Because :complete_<model> factories are generated with booleans set as true
-%>
        assert_select 'div', text: Regexp.new('true')
<%
  else
-%>
        assert_select 'div', text: Regexp.new('<%= attribute.factory_value.to_s %>')
<%
  end
end
-%>
      end
    end
  end
end
