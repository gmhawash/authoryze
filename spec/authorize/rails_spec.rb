describe Authoryze::Rails do
  describe '.setup' do
    it 'injects ControllerExtensions into ActionController::Base' do
      described_class.should_receive(:defined?).with(Rails).and_return(true)
      described_class.should_receive(:defined?).with(ActionController::Base).and_return(true)

    end
  end
end
