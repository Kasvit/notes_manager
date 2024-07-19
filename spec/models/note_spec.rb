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
require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'search' do
    let(:note) { create(:note, title: 'test', content: 'welcome') }

    before { note }

    it 'returns created note' do
      expect(Note.search('test').count).to eq(1)
    end

    it "returns blank array when can't find" do
      expect(Note.search('John Dou')).to eq([])
    end
  end
end
