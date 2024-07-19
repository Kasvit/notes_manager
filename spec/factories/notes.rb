# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :note do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph_by_chars(number: rand(40..500)) }
  end
end
