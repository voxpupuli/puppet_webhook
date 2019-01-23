# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v1.6.1](https://github.com/voxpupuli/puppet_webhook/tree/v1.6.1) (2019-01-15)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.6.1...v1.6.1)

**Fixed bugs:**

- Ensure that the ssl cert/key content is sent to WEBrick, not the path [\#84](https://github.com/voxpupuli/puppet_webhook/pull/84) ([dhollinger](https://github.com/dhollinger))

## [v1.6.1](https://github.com/voxpupuli/puppet_webhook/tree/v1.6.1) (2018-12-23)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.6.0...v1.6.1)

**Fixed bugs:**

- Change webrick log constants to strings to match conf file [\#80](https://github.com/voxpupuli/puppet_webhook/pull/80) ([dhollinger](https://github.com/dhollinger))

## [v1.6.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.6.0) (2018-12-19)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.5.2...v1.6.0)

**Implemented enhancements:**

- Add Sidekiq support [\#75](https://github.com/voxpupuli/puppet_webhook/issues/75)
- Add Tests for the application [\#8](https://github.com/voxpupuli/puppet_webhook/issues/8)

**Fixed bugs:**

- Logging settings don't work properly [\#77](https://github.com/voxpupuli/puppet_webhook/issues/77)

**Closed issues:**

- Build RPM/DEB/Arch Packages [\#25](https://github.com/voxpupuli/puppet_webhook/issues/25)
- Documentation [\#9](https://github.com/voxpupuli/puppet_webhook/issues/9)

**Merged pull requests:**

- Ensure that loglevel is using the const value [\#78](https://github.com/voxpupuli/puppet_webhook/pull/78) ([dhollinger](https://github.com/dhollinger))
- Add Sidekiq support [\#76](https://github.com/voxpupuli/puppet_webhook/pull/76) ([dhollinger](https://github.com/dhollinger))

## [v1.5.2](https://github.com/voxpupuli/puppet_webhook/tree/v1.5.2) (2018-11-02)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.5.1...v1.5.2)

**Merged pull requests:**

- Only load mco and chatops plugins if enabled [\#66](https://github.com/voxpupuli/puppet_webhook/pull/66) ([dhollinger](https://github.com/dhollinger))

## [v1.5.1](https://github.com/voxpupuli/puppet_webhook/tree/v1.5.1) (2018-11-02)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.5.0...v1.5.1)

**Merged pull requests:**

- Remove global mcollective requirement as it has been moved into a plugin [\#63](https://github.com/voxpupuli/puppet_webhook/pull/63) ([dhollinger](https://github.com/dhollinger))

## [v1.5.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.5.0) (2018-11-02)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.4.0...v1.5.0)

**Implemented enhancements:**

- Add tests to validate posts to the module route  [\#37](https://github.com/voxpupuli/puppet_webhook/pull/37) ([dhollinger](https://github.com/dhollinger))

**Fixed bugs:**

- puppet\_webhook is not compatible with Ruby \< 2.2.2 [\#56](https://github.com/voxpupuli/puppet_webhook/issues/56)

**Merged pull requests:**

- Bitbucket Server \(stash\) detection / JSON updates [\#61](https://github.com/voxpupuli/puppet_webhook/pull/61) ([ChetHosey](https://github.com/ChetHosey))
- Stray payload reference [\#60](https://github.com/voxpupuli/puppet_webhook/pull/60) ([ChetHosey](https://github.com/ChetHosey))
- Changed minimum versions to Puppet 5/Ruby 2.2 [\#58](https://github.com/voxpupuli/puppet_webhook/pull/58) ([ChetHosey](https://github.com/ChetHosey))
- Add tests for the DataParsers helper module [\#55](https://github.com/voxpupuli/puppet_webhook/pull/55) ([dhollinger](https://github.com/dhollinger))

## [v1.4.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.4.0) (2018-05-02)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.3.0...v1.4.0)

**Implemented enhancements:**

- Rocketchat plugin [\#53](https://github.com/voxpupuli/puppet_webhook/pull/53) ([dhollinger](https://github.com/dhollinger))
- ChatOps Plugin Support [\#52](https://github.com/voxpupuli/puppet_webhook/pull/52) ([dhollinger](https://github.com/dhollinger))

## [v1.3.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.3.0) (2018-04-24)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- Add additional Slack options. [\#50](https://github.com/voxpupuli/puppet_webhook/pull/50) ([dhollinger](https://github.com/dhollinger))
- Async routes [\#49](https://github.com/voxpupuli/puppet_webhook/pull/49) ([dhollinger](https://github.com/dhollinger))

## [v1.2.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.2.0) (2018-04-06)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.1.0...v1.2.0)

**Merged pull requests:**

- Clarify that mco is not a hard requirement [\#47](https://github.com/voxpupuli/puppet_webhook/pull/47) ([binford2k](https://github.com/binford2k))

## [v1.1.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.1.0) (2018-03-06)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.0.0...v1.1.0)

**Implemented enhancements:**

- Allow github to send form-urlencoded payloads and bug fix in webrick\_opts [\#45](https://github.com/voxpupuli/puppet_webhook/pull/45) ([williamberman](https://github.com/williamberman))

**Closed issues:**

- Refactor binary to pass configuration values from file or CLI [\#27](https://github.com/voxpupuli/puppet_webhook/issues/27)

**Merged pull requests:**

- Replace all MCollective agent calls with the agent lib. [\#44](https://github.com/voxpupuli/puppet_webhook/pull/44) ([dhollinger](https://github.com/dhollinger))

## [v1.0.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.0.0) (2017-12-21)
[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v0.1.0...v1.0.0)

**Implemented enhancements:**

- \(\#puppethack\) Add cli binary [\#40](https://github.com/voxpupuli/puppet_webhook/pull/40) ([dhollinger](https://github.com/dhollinger))

**Closed issues:**

- Move all routes into a routes/ directory [\#26](https://github.com/voxpupuli/puppet_webhook/issues/26)

**Merged pull requests:**

- Update config options and docs [\#41](https://github.com/voxpupuli/puppet_webhook/pull/41) ([dhollinger](https://github.com/dhollinger))
- Fix payload gentypes [\#39](https://github.com/voxpupuli/puppet_webhook/pull/39) ([dhollinger](https://github.com/dhollinger))
- Add simple config.ru file [\#38](https://github.com/voxpupuli/puppet_webhook/pull/38) ([dhollinger](https://github.com/dhollinger))
- Switch to using rack-bodyparser [\#36](https://github.com/voxpupuli/puppet_webhook/pull/36) ([alexjfisher](https://github.com/alexjfisher))
- Move routes into a routes directory [\#35](https://github.com/voxpupuli/puppet_webhook/pull/35) ([dhollinger](https://github.com/dhollinger))
- Fix generate\_types typo [\#34](https://github.com/voxpupuli/puppet_webhook/pull/34) ([alexjfisher](https://github.com/alexjfisher))
- Fix Code Climate badges [\#33](https://github.com/voxpupuli/puppet_webhook/pull/33) ([alexjfisher](https://github.com/alexjfisher))
- Add reporting to CodeClimate and associated badges [\#32](https://github.com/voxpupuli/puppet_webhook/pull/32) ([alexjfisher](https://github.com/alexjfisher))
- Report coverage to Codacy and add badge [\#31](https://github.com/voxpupuli/puppet_webhook/pull/31) ([alexjfisher](https://github.com/alexjfisher))

## [v0.1.0](https://github.com/voxpupuli/puppet_webhook/tree/v0.1.0) (2017-11-17)
**Implemented enhancements:**

- Cleanup config loader [\#2](https://github.com/voxpupuli/puppet_webhook/issues/2)

**Closed issues:**

- Validate github webhooks [\#6](https://github.com/voxpupuli/puppet_webhook/issues/6)
- Add VoxPupuli Gem Plumbing [\#3](https://github.com/voxpupuli/puppet_webhook/issues/3)

**Merged pull requests:**

- Development release 0.1.0 [\#24](https://github.com/voxpupuli/puppet_webhook/pull/24) ([dhollinger](https://github.com/dhollinger))
- Add rubygems deploy to travis [\#23](https://github.com/voxpupuli/puppet_webhook/pull/23) ([dhollinger](https://github.com/dhollinger))
- Fix TFS checks and add more fixtures/tests [\#22](https://github.com/voxpupuli/puppet_webhook/pull/22) ([dhollinger](https://github.com/dhollinger))
- Fix README badges after project rename [\#21](https://github.com/voxpupuli/puppet_webhook/pull/21) ([dhollinger](https://github.com/dhollinger))
- Finished renaming gem to puppet\_webhook [\#20](https://github.com/voxpupuli/puppet_webhook/pull/20) ([dhollinger](https://github.com/dhollinger))
- Preparing the README for Pre-Release [\#19](https://github.com/voxpupuli/puppet_webhook/pull/19) ([dhollinger](https://github.com/dhollinger))
- Clean up configuration code [\#18](https://github.com/voxpupuli/puppet_webhook/pull/18) ([dhollinger](https://github.com/dhollinger))
- Fix bug and add unit tests for stash payload [\#17](https://github.com/voxpupuli/puppet_webhook/pull/17) ([alexjfisher](https://github.com/alexjfisher))
- Move module\_name parsing into the Parser [\#16](https://github.com/voxpupuli/puppet_webhook/pull/16) ([dhollinger](https://github.com/dhollinger))
- Add first spec tests [\#15](https://github.com/voxpupuli/puppet_webhook/pull/15) ([alexjfisher](https://github.com/alexjfisher))
- Move repo\_user/name parsing to webhook\_json\_parser [\#14](https://github.com/voxpupuli/puppet_webhook/pull/14) ([alexjfisher](https://github.com/alexjfisher))
- Add run\_prefix\_command back [\#13](https://github.com/voxpupuli/puppet_webhook/pull/13) ([dhollinger](https://github.com/dhollinger))
- Add Apache 2.0 LICENSE file [\#12](https://github.com/voxpupuli/puppet_webhook/pull/12) ([alexjfisher](https://github.com/alexjfisher))
- Rubocop and travis [\#11](https://github.com/voxpupuli/puppet_webhook/pull/11) ([alexjfisher](https://github.com/alexjfisher))
- Refactor payload parsing [\#7](https://github.com/voxpupuli/puppet_webhook/pull/7) ([alexjfisher](https://github.com/alexjfisher))
- Get rack/parser working [\#5](https://github.com/voxpupuli/puppet_webhook/pull/5) ([dhollinger](https://github.com/dhollinger))
- POC for rack-parser [\#4](https://github.com/voxpupuli/puppet_webhook/pull/4) ([alexjfisher](https://github.com/alexjfisher))
- Putting the server in the load path [\#1](https://github.com/voxpupuli/puppet_webhook/pull/1) ([binford2k](https://github.com/binford2k))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
