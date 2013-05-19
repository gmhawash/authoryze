describe Authoryze::Rails do
  describe '.setup' do
    it 'injects ControllerExtensions into ActionController::Base' do
<<<<<<< HEAD
      described_class.should_receive(:defined?).with(Rails).and_return(true)
      described_class.should_receive(:defined?).with(ActionController::Base).and_return(true)

=======
      stub_const("Rails", :rails)
      stub_const("ActionController::Base", Class.new)
      stub_const("Authoryze::Rails::ControllerExtensions", Class.new)
      described_class.should_receive(:require).any_number_of_times
      ActionController::Base.should_receive(:include).with(Authoryze::Rails::ControllerExtensions)

      described_class.setup
    end

    it 'skips injection if Rails not defined' do
      stub_const("ActionController::Base", Class.new)
      described_class.should_not_receive(:require).any_number_of_times

      described_class.setup
    end

    it 'skips injection if ActionController::Base is not defined' do
      stub_const("Rails", Class.new)
      described_class.should_not_receive(:require).any_number_of_times

      described_class.setup
>>>>>>> Test rails_spec injection into ActionController::Base
    end
  end
end
