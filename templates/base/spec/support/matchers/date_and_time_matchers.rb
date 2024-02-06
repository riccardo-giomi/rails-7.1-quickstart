# frozen_string_literal: true

RSpec::Matchers.define :be_the_same_date do |expected|
  match do |actual|
    actual.in_time_zone == expected.in_time_zone
  end
end

RSpec::Matchers.define :be_the_same_time do |expected|
  match do |actual|
    actual.in_time_zone.strftime('%H:%M:%S') == expected.in_time_zone.strftime('%H:%M:%S')
  end
end
