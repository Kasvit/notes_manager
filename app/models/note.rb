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
class Note < ApplicationRecord
  validates :title, :content, presence: true

  def self.search(query)
    Note.where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
  end
end
