require 'rails_helper'

describe 'User visit homepage' do
  context 'Homepage' do
    it 'Should be able access homepage' do
      visit root_path

      expect(current_path).to eq(root_path)
    end
  end
end
