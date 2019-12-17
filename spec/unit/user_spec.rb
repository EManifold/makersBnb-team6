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

  describe '#login' do
    it 'Can log in with existing details' do
      return_user = User.login(email: 'bop', password: 'secret')
      expect(return_user.name).to eq('foop')
    end

    it "Can acknowledge incorrect details" do
      expect{ User.login(email: 'blart', password: 'secret') }.to raise_error
      expect{ User.login(email: 'bop', password: 'hidden') }.to raise_error
    end
  end

  describe '#find' do
    it 'Can obtain user by ID' do
      result = User.find(@created_user.id)
      expect(result.email).to eq(@created_user.email)
    end
  end
end
