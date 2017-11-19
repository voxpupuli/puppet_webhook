# Puppet Webhook Server

[![License](https://img.shields.io/github/license/voxpupuli/puppet_webhook.svg)](https://github.com/voxpupuli/puppet_webhook/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/voxpupuli/puppet_webhook.svg)](https://travis-ci.org/voxpupuli/puppet_webhook)
[![Gem Version](https://img.shields.io/gem/v/puppet_webhook.svg)](https://rubygems.org/gems/puppet_webhook)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet_webhook.svg)](https://rubygems.org/gems/puppet_webhook)
[![Maintainability](https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/maintainability)](https://codeclimate.com/github/codeclimate/codeclimate/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/test_coverage)](https://codeclimate.com/github/codeclimate/codeclimate/test_coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f73823762ec947889866c63c4ea47540)](https://www.codacy.com/app/VoxPupuli/puppet_webhook?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=voxpupuli/puppet_webhook&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet_webhook/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet_webhook?branch=master)
[![Dependency Status](https://gemnasium.com/badges/github.com/voxpupuli/puppet_webhook.svg)](https://gemnasium.com/github.com/voxpupuli/puppet_webhook)

## What is puppet_webhook

puppet_webhook is a Sinatra-based application receiving REST-based calls to trigger Puppet and r10k-related tasks such as:

* Webhooks from Source Code systems to trigger r10k environment and module deploys
* REST calls from systems to trigger Puppet Decommissions such as:
    * `puppet node clean`
    * `puppet cert clean`
    * `puppet cert revoke`
    * etc.
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

Once installed, you can run the application by simply executing the `puppet_webhook` binary.

This binary will default to using the bundled configuration files and run in a non-daemon mode. This mode is useful for debugging purposes, but it probably not ideal for production use.
You can also set the `server_type` option in `/etc/puppet_webhook/server.yml` to `daemon` to run the application in the background. By default the application will log to `/var/log/puppet_webhook/access.log`.

NOTE: During the Prerelease stage, the `/etc/puppet_webhook` and `/var/log/puppet_webhook` directories need to be manually created. This will be fixed in for General Availability.

### Configuring puppet_webhook

Puppet_webhook also has several configuration options that can be configured to each user's needs.

The configuration is separated out into Server config (`server.yml`) and Application config (`app.yml`).
There are default configuration files included in the application's config directory. While these files are editable, it is preferable to create these config files in `/etc/puppet_webhook` to limit potential problems with package updates.
Any configuration option is placed in `/etc/puppet_webhook/server.yml` or `/etc/puppet_webhook/app.yml` will override the default config defined in `APPDIR/config/server.yml` and `APPDIR/config/app.yml`.

#### Configuration options

#### server.yml

#####`server_type`
Determines if the Webrick server should run in Simple or Daemon mode.     
* Valid options: [ `simple`, `daemon` ].      
* Default: `simple` 

##### `logfile`
Location to write the log file to.
* Default: `/var/log/puppet_webhook/access.log`

##### `pidfile`
Location of the application's PID file
* Default: `/var/run/puppet_webhook/webhook.pid`

##### `lockfile`
Location of the application's Lockfile
* Default: `/var/run/puppet_webhook/webhook.lock`

##### `approot`
Location of the Root of the application's directory
* Default: `./`
NOTE: Currently unused

##### `bind_address`
IPv4 Address to bind to.
* MUST BE VALID IPv4 ADDRESS.
* Default: `0.0.0.0`

##### `port`
Port number to bind to.
* Valid options: Integer between `1024` and `65535`
* Default: `8088`

##### `enable_ssl`
Whether or not to enable SSL communication.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `verify_ssl`
Whether or not to verify the SSL CA/Peer on the certifcate. Set to false if using a self-signed certificate and the CA is not installed locally.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `public_key_path`
Path to the public SSL certificate for puppet_webhook. REQUIRED IF `ssl_enable` IS SET TO `true`
* Default: ''

##### `private_key_path`
Path to the SSL Private Key for puppet_webhook. REQUIRED IF `ssl_enable` IS SET TO `true`
* Default: ''

##### `command_prefix`
Command to prefix the r10k and puppet commands with when executed.
* Default: 'umask 0022;'

#### app.yml

##### `enable_mutex_lock`
Force all requests to syncronize on a mutex lock, ensuring that only a single request is processed at a time.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### `user`
User for which the sending application must authenticate with.
* Default: `puppet`

##### `pass`
Password for which the sending application must authenticate with.
* Default: `puppet`

##### `protected`
Whether or not to require authentication when sending to puppet_webhook.
* Valid options: [ `true`, `false` ]
* Default: `true`

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

##### discovery_timeout
MCollective Ruby discovery timeout. REQUIRES `use_mco_ruby` TO BE `true`.
* Default: `'10'`

##### use_mcollective
Whether or not to use MCollective CLI command. REQUIRES MCOLLECTIVE AND MCOLLECTIVE R10K.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### slack_webhook
Whether or not to use Slack Notifications.
* Valid options: [ `true`, `false` ]
* Default: `false`

##### slack_channel
Slack channel to notify.
* Default: `'#default'`

##### slack_user
Slack user to notify as.
* Default: `'r10k'`

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
* Default: `false`

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
