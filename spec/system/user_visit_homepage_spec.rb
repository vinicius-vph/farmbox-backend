require 'rails_helper'

describe 'User visit homepage' do
  context 'Homepage' do
    it 'Should be able access homepage' do
      visit root_path

      expect(current_path).to eq(root_path)
    end
    it 'Should be able view nav content' do
      visit root_path

      expect(page).to have_selector(:css, 'nav img#nav-logo')
      expect(page).to have_link('Entrar')
    end
    it 'Should be able view body content' do
      visit root_path

      expect(page).to have_text('Bem vindo ao')
      expect(page).to have_selector(:css, 'section img.flex')
    end
  end
end
