describe Fastlane::Actions::YarnAction do
  describe 'yarn install action' do
    it 'default use case' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :install do
        yarn(command: 'install', package_path: 'spec/fixtures')
      end").runner.execute(:install)

      expect(result).to eq("cd spec && yarn install")
    end
    it 'run some script with some option' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: '--fail-fast', package_path: 'spec/fixtures')
      end").runner.execute(:test)

      expect(result).to eq("cd spec && yarn test -- --fail-fast")
    end
    it 'run some script with some option provided as list' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: ['--fail-fast', 'please'], package_path: 'spec/fixtures')
      end").runner.execute(:test)

      expect(result).to eq("cd spec && yarn test -- --fail-fast please")
    end
    it 'fail if package_path and project root are both provided' do

      expect {
        Fastlane::FastFile.new.parse("lane :boom do
          yarn(command: 'test', package_path: 'spec/fixtures', project_root:'racine')
        end").runner.execute(:boom)
      }.to raise_error FastlaneCore::Interface::FastlaneError, "Unresolved conflict between options: 'package_path' and 'project_root'"
    end
  end
end
