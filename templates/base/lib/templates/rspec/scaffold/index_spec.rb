# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/index' do
  include Pagy::Backend

  before do
    create_list(:complete_<%= singular_table_name %>, 2)

    @pagy, @<%= ns_table_name %> = pagy(<%= class_name %>.all)
    assign(:<%= ns_table_name %>, @<%= ns_table_name %>)
  end

  it 'renders a list of <%= ns_table_name %>' do
    render

    @<%= ns_table_name %>.each do |<%= singular_table_name %>| # rubocop:disable RSpec/InstanceVariable
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
        assert_select '<%= expected_tag %>', '<%= expected_filename %>' # <%= attribute.name %>
<%
  elsif attribute.type == :boolean
    # Because :complete_<model> factories are generated with booleans set as true
-%>
        assert_select 'div', text: Regexp.new('true') # <%= attribute.name %>
<%
  elsif attribute.type.in? %i[datetime date time timestamp]
    type = attribute.type == :timestamp ? :datetime : attribute.type
    expected_value = attribute.factory_value.try(:"to_#{type}")
    expected_value = I18n.l(expected_value, format: :"template_#{type}")
-%>
        assert_select 'div', text: Regexp.new('<%= expected_value %>') # <%= attribute.name %>
<%
  elsif attribute.extended_type == :title
    attribute_value = attribute.factory_value.to_s
-%>
        assert_select 'div', html: Regexp.new('href=".*<%= ns_table_name%>\/\d+".*><%= attribute_value %>') # <%= attribute.name %>
<%
  else
-%>
        assert_select 'div', text: Regexp.new('<%= attribute.factory_value.to_s %>') # <%= attribute.name %>
<%
  end
end
-%>
      end
    end
  end
end
