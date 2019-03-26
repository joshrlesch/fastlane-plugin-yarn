module Fastlane
  module Helper
    class YarnHelper
      # class methods that you define here become available in your action
      # as `Helper::YarnHelper.your_method`

      attr_accessor :flags
      attr_accessor :commands
      attr_accessor :options
      attr_accessor :package_path
      attr_accessor :project_root
      attr_accessor :yarn

      def initialize(package_path: nil, project_root:nil)
        self.package_path = package_path

        if self.package_path
          self.yarn = "cd #{File.dirname(self.package_path)} && yarn"
        elsif
          self.yarn = "cd #{self.project_root} && yarn"
        else
          self.yarn = "yarn"
        end
      end

      # Run a certain action
      def trigger(command: nil, flags: nil, options: nil, print_command: true, print_command_output: true)
        unless options == "" || options == [] || options == nil then
          option_string = options.respond_to?(:join) ? "-- #{options.join(" ")}" : "-- #{options}"
        end
        command = [self.yarn, flags, command, option_string].compact.join(" ")
        Action.sh(command, print_command: print_command, print_command_output: print_command_output)
      end

      def check_install
        check_package
        begin
          command = [self.yarn, "--version"].compact.join(" ")
          Action.sh(command, print_command: false, print_command_output: false)
        rescue Errno::ENOENT => e
          UI.error("Yarn not installed, please install with Homebrew or npm.")
          raise e
        end
      end

      def install_dependencies
        UI.message("Installing dependencies")
        trigger(command: "install")
      end

      def check_package
        if self.package_path.nil?
          package_path = 'package.json'
        else
          package_path = self.package_path
        end

        unless File.exist?(package_path)
          UI.error("Could not find package.json")
          raise Errno::ENOENT
        end
      end
    end
  end
end
