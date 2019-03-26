module Fastlane
  module Actions
    class YarnAction < Action
      def self.run(params)
        flags = params[:flags]
        command = params[:command]
        options = params[:options]
        package_path = params[:package_path]

        # create a new object from yarn helper
        yarn = Helper::YarnHelper.new(package_path: package_path)

        # Check if yarn is installed
        yarn.check_install

        if params[:auto_install_dependencies]
          UI.message("Installing dependecies")
          yarn.install_dependencies
        end

        # trigger command
        yarn.trigger(command: command, flags: flags, options: options)
      end

      def self.description
        "Execute Yarn commands from your Fastfile"
      end

      def self.authors
        ["Josh Lesch"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Execute Yarn commands from your Fastfile"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :flags,
                                       env_name: "YARN_FLAGS",
                                       description: "Flags you want Yarn to perform as listed in package.json file",
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :command,
                                       env_name: "YARN_COMMAND",
                                       description: "Command you want Yarn to perform, e.g. 'add' or 'upgrade'",
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :package_path,
                                       env_name: "PACKAGE_PATH",
                                       description: "Path to package.json file",
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :options,
                                       env_name: "YARN_OPTIONS",
                                       description: "Options to pass to Yarn",
                                       optional: true,
                                       is_string:false,
                                       verify_block: ->(value) {
                                         case value
                                          when String
                                            @options = value
                                          when Array
                                            @options = value.join(" ")
                                          else
                                            UI.user_error! "Invalid option: #{value.inspect}"
                                          end
                                          @options = "-- #{@options}" if @option
                                          }),
          FastlaneCore::ConfigItem.new(key: :auto_install_dependencies,
                                       env_name: "AUTO_INSTALL_DEPENDENCIES",
                                       description: "Runs yarn install before executing any yarn command",
                                       optional: true,
                                       default_value: false,
                                       is_string: false)

        ]
      end


      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
