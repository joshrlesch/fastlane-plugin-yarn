# yarn plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-yarn)
[![Gem](https://img.shields.io/gem/v/fastlane-plugin-yarn.svg)](https://rubygems.org/gems/fastlane-plugin-yarn/versions/1.1)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-yarn`, add it to your project by running:

```bash
fastlane add_plugin yarn
```

## About yarn

Execute Yarn commands from your Fastfile
 
When using the yarn action in your fastfile, it will install any dependencies that may have changed in your package.json file
It will by default look for your package.json file in the root directory, or you can choose a different location.
```ruby
yarn(
  command: "test",
  package_path: "../package.json"
)
```

Yarn Options

```
+---------------------------+---------------------------+---------------------------+---------+
|                                        yarn Options                                         |
+---------------------------+---------------------------+---------------------------+---------+
| Key                       | Description               | Env Var                   | Default |
+---------------------------+---------------------------+---------------------------+---------+
| flags                     | Flags you want Yarn to    | YARN_FLAGS                |         |
|                           | perform as listed in      |                           |         |
|                           | package.json file         |                           |         |
| command                   | Command you want Yarn to  | YARN_COMMAND              |         |
|                           | perform, e.g. 'add' or    |                           |         |
|                           | 'upgrade'                 |                           |         |
| package_path              | Path to package.json file | PACKAGE_PATH              |         |
| project_root              | package.json folder       | PROJECT_ROOT              |         |
| options                   | Options to pass to Yarn   | YARN_OPTIONS              |         |
| auto_install_dependencies | Runs yarn install before  | AUTO_INSTALL_DEPENDENCIES | false   |
|                           | executing any yarn        |                           |         |
|                           | command                   |                           |         |
+---------------------------+---------------------------+---------------------------+---------+
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About `fastlane`

`fastlane` is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
