describe Fastlane::Actions::YarnAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The yarn plugin is working!")

      Fastlane::Actions::YarnAction.run(nil)
    end
  end
end
