# frozen_string_literal: true

module Rails
  module Generators
    # Rails class that handles how arguments from generator calls inform the templates used.
    # Rewritten to allow for additional types that
    class GeneratedAttribute
      attr_accessor :extended_attr_options

      def extended_type
        extended_attr_options[:type]
      end

      class << self
        alias original_parse parse

        def parse(*)
          attribute = original_parse(*)
          attribute.extended_attr_options = attribute.attr_options.delete(:extended) || {}
          attribute
        end

        private

        alias original_parse_type_and_options parse_type_and_options

        def parse_type_and_options(type) # rubocop:disable Metrics/MethodLength
          case type
          when 'title'
            ['string', { null: false, extended: { type: :title } }]
          when /title\{(\d+)\}/
            ['string', { limit: ::Regexp.last_match(2).to_i, null: false, extended: { type: :title } }]
          when 'abstract'
            ['text', { extended: { type: :abstract } }]
          when 'image'
            ['attachment', { extended: { type: type.to_sym } }]
          when 'images'
            ['attachments', { extended: { type: type.to_sym } }]
          when 'boolean'
            # Because RuboCop told me so, false should be a reasonable default
            [type, { null: false, default: false }]
          else
            original_parse_type_and_options(type)
          end
        end
      end

      def factory_value # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
        @factory_value ||= case type
                           when :string, :text
                             "#{name.capitalize} Value"
                           when :integer
                             rand(1..99)
                           when :float
                             rand(1.0..9.9)
                           when :decimal
                             rand(1.0..9.9).to_s
                           when :datetime, :timestamp
                             "20#{rand(10..23)}-#{rand(1..12)}-#{rand(1..28)} #{rand(0..23)}:#{rand(0..59)}:#{rand(0..59)}"
                           when :date
                             "20#{rand(10..23)}-#{rand(1..12)}-#{rand(1..28)}"
                           when :time
                             "#{rand(0..23)}:#{rand(0..59)}:#{rand(0..59)}"
                           when :boolean
                             false
                           when :references, :belongs_to,
                                :attachment, :attachments,
                                :rich_text
                             nil
                           else
                             ''
                           end
      end
    end
  end
end
