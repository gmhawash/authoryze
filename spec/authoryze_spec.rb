describe Authoryze do

  describe '.configure' do
    it 'yields configuration if block given' do
      configuration = double
      described_class.stub(:configuration => configuration)
      described_class.should_receive(:configure).and_yield(configuration)
      described_class.configure {|c| }
    end

    it 'raises an error if block not given' do
      expect{
        described_class.configure
      }.to raise_error ArgumentError
    end
  end

  describe '.configuration' do
    it 'returns a new configuration object' do
      Authoryze::Configuration.should_receive(:new).and_call_original
      described_class.configuration.should be_an_instance_of Authoryze::Configuration
    end

    it 'returns memoized version' do
      configuration = described_class.configuration
      described_class.configuration.should == configuration
    end
  end

  describe '#can', :pending => true do
    it 'returns true if user has permission' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      user = create :user, :roles => [role]
      subject.stub(:current_user => user)
      subject.can.manage_peons?.should be_true
    end

    it 'raises AccessDenied error if user does not have permission' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      user = create :user, :roles => [role]
      subject.stub(:current_user => user)
      subject.can.manage_big_boss?.should be_false
    end

    it 'returns true for permissions from any of the roles' do
      role = Role.create :name => 'boss', :permissions => {'manage_peons?' => true}
      role2 = Role.create :name => 'boss2', :permissions => {'manage_underlings?' => true}
      user = create :user, :roles => [role, role2]
      subject.stub(:current_user => user)
      subject.can.manage_peons?.should be_true
      subject.can.manage_underlings?.should be_true
    end
  end
end

