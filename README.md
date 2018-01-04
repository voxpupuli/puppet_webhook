# Puppet Webhook Server

[![License](https://img.shields.io/github/license/voxpupuli/puppet_webhook.svg)](https://github.com/voxpupuli/puppet_webhook/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/voxpupuli/puppet_webhook.svg)](https://travis-ci.org/voxpupuli/puppet_webhook)
[![Gem Version](https://img.shields.io/gem/v/puppet_webhook.svg)](https://rubygems.org/gems/puppet_webhook)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet_webhook.svg)](https://rubygems.org/gems/puppet_webhook)
[![Maintainability](https://api.codeclimate.com/v1/badges/f4f083a54a85f4cc97f0/maintainability)](https://codeclimate.com/github/voxpupuli/puppet_webhook/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f4f083a54a85f4cc97f0/test_coverage)](https://codeclimate.com/github/voxpupuli/puppet_webhook/test_coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f73823762ec947889866c63c4ea47540)](https://www.codacy.com/app/VoxPupuli/puppet_webhook?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=voxpupuli/puppet_webhook&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet_webhook/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet_webhook?branch=master)
[![Dependency Status](https://gemnasium.com/badges/github.com/voxpupuli/puppet_webhook.svg)](https://gemnasium.com/github.com/voxpupuli/puppet_webhook)

## What is puppet_webhook

puppet_webhook is a Sinatra-based application receiving REST-based calls to trigger Puppet and r10k-related tasks such as:

* Webhooks from Source Code systems to trigger r10k environment and module deploys
* Send notifications via Slack

## Prerequisites

* Ruby 2.1.9 or greater
* Puppet 4.7.1 or greater
* r10k gem
* MCollective and MCollective-r10k (Only for multi-master syncronization)
    * Currently Mcollective-r10k is only available from [puppet-r10k](https://github.com/voxpupuli/puppet-r10k)

## Installation

Currently the only supported installation method is via RubyGems. 

`gem install puppet_webhook`

NOTE: RPM, DEB, and Arch packages are planned for future releases.

## Usage

### Running puppet_webhook

#### Quick Start

Simply run `# puppet_webhook` after installation to start puppet_webhook in non-daemon mode on your system. This is great for testing the server out.

#### CLI Tool

The `puppet_webhook` CLI command has several options you can pass it as well.

To see these options run `# puppet_webook -h` in your terminal to see all the options.

#### Start using Rack-based server software

A `config.ru` file is also packaged with the application to provide users with the ability to start the app using their own rack-based server such as
unicorn or puma. It will use the defaults passed to it by said server.

#### Service Start

Once the native packages are built, they will include default systemd and/or sysvinit service files that you can use to start puppet_webhook as well.

### Configuring puppet_webhook

Puppet_webhook also has several configuration options that can be configured to each user's needs.

The configuration is separated out into Server config (`server.yml`) and Application config (`app.yml`).
There are default configuration files included in the application's config directory. While these files are editable, it is preferable to create these config files in `/etc/puppet_webhook` to limit potential problems with package updates.
Any configuration option is placed in `/etc/puppet_webhook/server.yml` or `/etc/puppet_webhook/app.yml` will override the default config defined in `APPDIR/config/server.yml` and `APPDIR/config/app.yml`.

#### Configuration options

#### Command-Line Options

* `-h, --help`: Display the default help output.
* `-d, --debug`: Set logging to debug mode.
* `-l [LOGFILE], --logfile [LOGFILE]`: Define a logfile to log to.
* `-p PORT, --port PORT`: Define port to listen on. Default: `8088`
* `-D, --daemon`: Run WEBrick in Daemon mode.
* `--pidfile FILE`: Define the PID File for the application's process. Default: `/var/run/puppet_webhook/webhook.pid`
* `--ssl`: Enable SSL Support.
* `--ssl-cert FILE`: Specify the SSL cert to use. Pair with `--ssl-key`. Requires `--ssl` option or `ssl_enable: true` in config file.
* `--ssl-key FILE`: Specify the SSL Private key to use. Pair with `--ssl-cert`. Requires `--ssl` or `ssl_enable: true` in config file.
* `-c FILE, --configfile FILE`: Specifies a config file to use. Must be a `.yml` file in YAML format.


#### Server Configuration File

The Server configuration file is a YAML formatted file with file extension `.yml` and defined with the `-c` or `--configfile`
command line option. These settings are exclusively for setting server configs and currently will override any command line settings
passed.

When using the default SystemD unit file or SysVInit service file, the server configuration file will default to `/etc/puppet_webhook/server.yml` (Not implemented yet).

##### Options

##### `server_type`

Determines if the Webrick server should run in Simple or Daemon mode.     
* Valid options: [ `simple`, `daemon` ].      
* Default: `simple` 

##### `logfile`

Location to write the log file to.
* Default: `/var/log/puppet_webhook`

##### `loglevel`

Define the logging level.
* Default: `WARN`

##### `pidfile`

Location of the application's PID file
* Default: `/var/run/puppet_webhook/webhook.pid`

##### `port`

Port number to bind to.
* Valid options: Integer between `1024` and `65535`
* Default: `8088`

##### `enable_ssl`

Whether or not to enable SSL communication.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `ssl_verify`

Whether or not to verify the SSL CA/Peer on the certifcate. Set to false if using a self-signed certificate and the CA is not installed locally.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `ssl_cert`

Path to the public SSL certificate for puppet_webhook. REQUIRED IF `ssl_enable` IS SET TO `true`

##### `ssl_key`

Path to the SSL Private Key for puppet_webhook. REQUIRED IF `ssl_enable` IS SET TO `true`

#### Application Configuration File

This file stores the configuration for the Application itself. A default configuration file is included in the `APP_ROOT/config/app.yml`.

The SystemD unit and SysVInit service files will use `/etc/puppet_webhook/app.yml` by default (Not implemented yet).

Currently, the above two locations are the only valid locations for the app.yml file. Like the Server Config, it must be a .yml file in YAML format.

##### Options

##### `protected`

Whether or not to require authentication when sending to puppet_webhook.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `user`

User for which the sending application must authenticate with. Required if `protected` is true.

##### `pass`

Password for which the sending application must authenticate with. Require if `protected` is true.

##### client_cfg

Mcollective client configuration file.
* Default: `/var/lib/peadmin/.mcollective`

##### client_timeout

Mcollective client timeout in seconds.
* MUST BE A STRING
* Default: `"120"`

##### use_mco_ruby

Whether or not to execute MCollective via Ruby Client Library or not. REQUIRES MCOLLECTIVE AND MCOLLECTIVE R10K!
* Valid options: [ `true`, `false` ]
* Default: `false`

##### use_mcollective

Whether or not to use MCollective CLI command. REQUIRES MCOLLECTIVE AND MCOLLECTIVE R10K.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### discovery_timeout

MCollective Ruby discovery timeout. REQUIRES `use_mco_ruby` TO BE `true`.
* Default: `'10'`

##### slack_webhook

Whether or not to use Slack Notifications.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### slack_proxy_url

The proxy URL for Slack if used.
* MUST BE A VALID URL.
* Default: `nil`

##### default_branch

The default git branch to use with the r10k Control Repo.
* Default: `production`

##### ignore_environment

An Array of environments for r10k to ignore during deployment.
* Default: []

##### prefix

r10k Environment Prefix to use. When set to `repo`, `user`, or `command`, the prefix will be generated from the repo_name, repo_user, or `prefix_command`. Otherwise it will set the prefix to the passed string. `false` disables prefix.
* Valid Options: [ `repo`, `user`, `command`, `<String_value>`, `false` ]
* Default: `nil`

##### prefix_command

Command to execute that will generate an r10k environment prefix.
* Default: ''

##### r10k_deploy_arguments

r10k command arguments to pass to the `r10k deploy environment` command.
* Default: `"-pv"`

##### allow_uppercase

Whether or not to allow uppercase letters in environment names. If false, then puppet_webhook assumes environment names are downcase. If `true`, then puppet_webhook will normalize the environment name.
* Valid options: [ `true`, `false` ]
* Default: `true`

##### github_secret

Used to verify the signature on a repo. Currently only supported for Github repos.
* MUST BE A VALID OPENSSL `sha1` HASH.
* Default: `nil`

##### repository_events

Array of webhook events to ignore.
* Default: `nil`

## Getting Help

* IRC: Vox Pupuli has a dedicated channel, `#voxpupuli`, on Freenode where `puppet_webhook` questions can be directed.
* Mailing Lists: [voxpupuli](https://groups.io/g/voxpupuli)
* Slack: Vox Pupuli has a dedicated Slack Channel, `#voxpupuli`, on  the [Puppet Community](https://slack.puppet.com/) Slack.

## Contributors

A big thank you to all our [Contributor](https://github.com/voxpupuli/puppet_webhook/graphs/contributors)

## License

See LICENSE
