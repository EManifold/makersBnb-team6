describe User do

before(:each) do
  @created_user = User.create(email: 'bop', name: 'foop', username: 'zee', password: 'secret')
end

  describe '#create' do
    it 'Should create user instance with name attribute' do
      expect(@created_user.name).to eq('foop')
    end

    it 'Should make a secure password' do
      expect(BCrypt::Password).to receive(:create).with('Cheese')
      User.create(email: 'goggle', username: 'dog', name: 'strong', password: 'Cheese')
    end
  end

  # describe '#login' do
  #   it 'Can log in with existing details' do
  #     recurrent_user = User.login(email: 'bop', password: 'zee')
  #     expect(recurrent_user.name).to eq('foop')
  #   end
  # end
end
