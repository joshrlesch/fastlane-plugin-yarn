describe Fastlane::Actions::YarnAction do
  describe 'yarn install action' do
    it 'default use case' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'install', package_path: 'spec/fixtures')
      end").runner.execute(:test)

      expect(result).to eq("cd spec && yarn install")
    end
    it 'run some script with some option' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: '--fail-fast', package_path: 'spec/fixtures')
      end").runner.execute(:test)

      expect(result).to eq("cd spec && yarn test --fail-fast")
    end
  end
end
