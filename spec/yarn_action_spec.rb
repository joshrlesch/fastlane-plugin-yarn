describe Fastlane::Actions::YarnAction do
  describe 'yarn install action' do
    it 'default use case' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :install do
        yarn(command: 'install', package_path: 'spec/fixtures/package.json')
      end").runner.execute(:install)

      expect(result).to eq("cd spec/fixtures && yarn install")
    end
    it 'default use case (with project root)' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :install do
        yarn(command: 'install', project_root: 'spec/fixtures')
      end").runner.execute(:install)

      expect(result).to eq("cd spec/fixtures && yarn install")
    end
    it 'run some script with some option' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: '--fail-fast', package_path: 'spec/fixtures/package.json')
      end").runner.execute(:test)

      expect(result).to eq("cd spec/fixtures && yarn test --fail-fast")
    end
    it 'run some script with some option with missing --' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: 'fail-fast', package_path: 'spec/fixtures/package.json')
      end").runner.execute(:test)

      expect(result).to eq("cd spec/fixtures && yarn test --fail-fast")
    end
    it 'run some script with some option provided as list' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: ['--fail-fast', 'please'], package_path: 'spec/fixtures/package.json')
      end").runner.execute(:test)

      expect(result).to eq("cd spec/fixtures && yarn test --fail-fast --please")
    end
    it 'run some script with some option provided as list, one with param value' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)

      result = Fastlane::FastFile.new.parse("lane :test do
        yarn(command: 'test', options: ['--fail-fast please', '--verbose'], package_path: 'spec/fixtures/package.json')
      end").runner.execute(:test)

      expect(result).to eq("cd spec/fixtures && yarn test --fail-fast please --verbose")
    end
    it 'fail if package_path and project root are both provided' do
      expect {
        Fastlane::FastFile.new.parse("lane :boom do
          yarn(command: 'test', package_path: 'spec/fixtures/package.json', project_root:'racine')
        end").runner.execute(:boom)
      }.to raise_error FastlaneCore::Interface::FastlaneError, "Unresolved conflict between options: 'package_path' and 'project_root'"
    end
  end
end
