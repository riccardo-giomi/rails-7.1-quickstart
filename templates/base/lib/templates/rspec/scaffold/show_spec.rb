# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/show' do
  before { assign :<%= singular_table_name %>, create(:complete_<%= singular_table_name %>) }

  it 'renders attributes' do
    render
<%
for attribute in attributes
  expected_value = if attribute.attachment? || attribute.attachments?
                     # Check templates/factory_bot/model/factories to see where these come from:
                     extension   = attribute.extended_type.in?([:image, :images]) ? 'jpg' : 'pdf'
                     image_index = attribute.attachments? ? '_1' : ''
                     "#{singular_table_name}_#{attribute.name}#{image_index}.#{extension}"
                   elsif attribute.type == :boolean
                     # Because :complete_<model> factories are generated with booleans set as true
                     'true'
                   else
                     attribute.default.to_s
                   end
-%>
    expect(rendered).to match(/<%= expected_value %>/) # #<%= attribute.name %>
<%
end
-%>
  end
end
