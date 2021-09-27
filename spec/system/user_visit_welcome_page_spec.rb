require 'rails_helper'

describe 'User visit Welcomepage' do
  context 'Welcomepage' do
    it 'Should be able access Welcomepage' do
      visit root_path
      click_on 'Entrar'

      expect(current_path).to_not eq(root_path)
      expect(current_path).to eq(welcome_index_path)
    end
    it 'Should be able view Welcomepage content' do
      visit root_path
      click_on 'Entrar'

      expect(page).to have_link('Voltar')
      expect(page).to have_text('Bem vindo, consulte abaixo suas Anotações de Campo')
    end
    context 'Back To Homepage' do
      it 'Should be able back to homepage' do
        visit welcome_index_path
        click_on 'Voltar'

        expect(current_path).to eq(root_path)
        expect(current_path).to_not eq(welcome_index_path)
      end
    end
  end
end
