module Fastlane
  module Helper
    class YarnHelper
      # class methods that you define here become available in your action
      # as `Helper::YarnHelper.your_method`

      attr_accessor :task
      attr_accessor :commands
      attr_accessor :package_path

      # Run a certain action
      def trigger(command: nil, task: nil, package_path: nil, print_command: true, print_command_output: true)
        if package_path
          Dir.chdir(File.dirname(package_path))
        end

        command = ["yarn", command, task].compact.join(" ")
        Action.sh(command, print_command: print_command, print_command_output: print_command_output)
      end

      def check_install
        begin
          Action.sh('yarn --version', print_command: false, print_command_output: false)
        rescue Errno::ENOENT => e
          UI.error("Yarn not installed, please install with Homebrew or npm.")
          raise e
        end
      end

      def check_package(package_path: nil)
        if package_path.nil?
          package_path = 'package.json'
        end

        unless File.exists?(package_path)
          UI.error("Could not find package.json")
          raise Errno::ENOENT
        end
      end
    end
  end
end
