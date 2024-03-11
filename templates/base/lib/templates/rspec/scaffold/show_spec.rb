# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/show' do
  before { assign :<%= singular_table_name %>, create(:complete_<%= singular_table_name %>) }
<%
if title_index = attributes.index { _1.extended_type == :title }
  attribute_name  = attributes[title_index].name
  attribute_value = attributes[title_index].factory_value.to_s
-%>
  it '<%= attribute_name %> is rendered and links to the show view' do
    render
    expect(rendered).to match(/href=".*<%= ns_table_name%>\/\d+".*><%= attribute_value %>/)
  end

<%
end
-%>
  it 'renders attributes' do
    render
<%
for attribute in attributes
  next if attribute.extended_type == :title
  expected_value = if attribute.attachment? || attribute.attachments?
                     # Check templates/factory_bot/model/factories to see where these come from:
                     extension   = attribute.extended_type.in?([:image, :images]) ? 'jpg' : 'pdf'
                     image_index = attribute.attachments? ? '_1' : ''
                     "#{singular_table_name}_#{attribute.name}#{image_index}.#{extension}"
                   elsif attribute.type == :boolean
                     # Because :complete_<model> factories are generated with booleans set as true
                     'true'

                   elsif attribute.type.in? %i[datetime date time timestamp]
                     type = attribute.type == :timestamp ? :datetime : attribute.type
                     value = attribute.factory_value.try(:"to_#{type}")
                     I18n.l(value, format: :"template_#{type}")
                   else
                     attribute.factory_value.to_s
                   end
-%>
    expect(rendered).to match(/<%= expected_value %>/) # #<%= attribute.name %>
<%
end
-%>
  end
end
