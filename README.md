# Puppet Webhook Server

[![License](https://img.shields.io/github/license/voxpupuli/puppet_webhook.svg)](https://github.com/voxpupuli/puppet_webhook/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/voxpupuli/puppet_webhook.svg)](https://travis-ci.org/voxpupuli/puppet_webhook)
[![Maintainability](https://api.codeclimate.com/v1/badges/f4f083a54a85f4cc97f0/maintainability)](https://codeclimate.com/github/voxpupuli/puppet_webhook/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f4f083a54a85f4cc97f0/test_coverage)](https://codeclimate.com/github/voxpupuli/puppet_webhook/test_coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f73823762ec947889866c63c4ea47540)](https://www.codacy.com/app/VoxPupuli/puppet_webhook?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=voxpupuli/puppet_webhook&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet_webhook/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet_webhook?branch=master)

## What is puppet_webhook

puppet_webhook is a Sinatra-based application receiving REST-based calls to trigger Puppet and r10k-related tasks such as:

* Webhooks from Source Code systems to trigger r10k environment and module deploys
* Send notifications via Slack

## Prerequisites

* Ruby 2.4.0 or greater
* Puppet 5.5.0 or greater
* r10k gem
* *Optional*: MCollective and MCollective-r10k (Provides one form of multi-master syncronization)
    * Currently Mcollective-r10k is only available from [puppet-r10k](https://github.com/voxpupuli/puppet-r10k)
    * If you don't want to use MCollective, you could install this webhook on each compile master instead

## Installation

### Legacy puppet_webhook (< 2.x)

Please see the pre-2.x [documentation](docs/LEGACY.md) if using the old gem-based puppet_webhook.

### Modern puppet_webhook (>= 2.x)

#### Generic

This assumes you already have the correct Ruby version installed in the system or via a tool like `rbenv`, `rvm`, or `asdf`.

1. Download the latest release from the [Releases](https://github.com/voxpupuli/puppet_webhook/releases) page.
2. Extract the tarball into the desired directory:
```bash
$ tar -xzvf puppet_webhook-latest.tar.gz -C /opt/puppet_webhook
```
3. Enter the install directory and install dependencies:
```bash
$ cd /opt/puppet_webhook && bundle install
```
4. Start the process:
```bash
$ bundle exec puma config.ru
```

