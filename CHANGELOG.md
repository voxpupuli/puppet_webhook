# Changelog

## [v2.1.2](https://github.com/voxpupuli/puppet_webhook/tree/v2.1.2) (2020-07-21)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v2.1.1...v2.1.2)

**Fixed bugs:**

- ArgumentError - wrong number of arguments \(given 1, expected 2\) [\#136](https://github.com/voxpupuli/puppet_webhook/issues/136)
- puppet-webhook 2.1.1 runs in development mode [\#131](https://github.com/voxpupuli/puppet_webhook/issues/131)
- Fix a parser issue with the module endpoint [\#137](https://github.com/voxpupuli/puppet_webhook/pull/137) ([dhollinger](https://github.com/dhollinger))
- Bugfix: Run Puma in production mode [\#135](https://github.com/voxpupuli/puppet_webhook/pull/135) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- Update r10k gem to 3.4.1 [\#121](https://github.com/voxpupuli/puppet_webhook/issues/121)

**Merged pull requests:**

- document webhook configuration [\#138](https://github.com/voxpupuli/puppet_webhook/pull/138) ([bastelfreak](https://github.com/bastelfreak))
- Update r10k and dependencies [\#133](https://github.com/voxpupuli/puppet_webhook/pull/133) ([dhollinger](https://github.com/dhollinger))
- Update gems to latest version [\#132](https://github.com/voxpupuli/puppet_webhook/pull/132) ([bastelfreak](https://github.com/bastelfreak))
- remove legacy travis config keys / use bionic as CI image [\#129](https://github.com/voxpupuli/puppet_webhook/pull/129) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.1](https://github.com/voxpupuli/puppet_webhook/tree/v2.1.1) (2020-06-23)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v2.1.0...v2.1.1)

**Merged pull requests:**

- Update puma version in vanagon [\#126](https://github.com/voxpupuli/puppet_webhook/pull/126) ([dhollinger](https://github.com/dhollinger))
- Bump puma from 4.3.3 to 4.3.5 [\#125](https://github.com/voxpupuli/puppet_webhook/pull/125) ([dependabot[bot]](https://github.com/apps/dependabot))
- Remove coveralls due to vulnerable dependencies [\#124](https://github.com/voxpupuli/puppet_webhook/pull/124) ([dhollinger](https://github.com/dhollinger))
- Added several package versions and a yum repo file [\#123](https://github.com/voxpupuli/puppet_webhook/pull/123) ([dhollinger](https://github.com/dhollinger))
- Update docker-compose file [\#120](https://github.com/voxpupuli/puppet_webhook/pull/120) ([dhollinger](https://github.com/dhollinger))
- Some docker fixes [\#119](https://github.com/voxpupuli/puppet_webhook/pull/119) ([dhollinger](https://github.com/dhollinger))

## [v2.1.0](https://github.com/voxpupuli/puppet_webhook/tree/v2.1.0) (2020-03-09)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- Add Warden and enforce token auth [\#82](https://github.com/voxpupuli/puppet_webhook/issues/82)
- Update tests to use WebMock instead of Rack::Test [\#72](https://github.com/voxpupuli/puppet_webhook/issues/72)
- Remove Puppet Server Requirement [\#70](https://github.com/voxpupuli/puppet_webhook/issues/70)

**Closed issues:**

- Breaks on Ruby 2.4 [\#104](https://github.com/voxpupuli/puppet_webhook/issues/104)

**Merged pull requests:**

- Improve the token generator [\#117](https://github.com/voxpupuli/puppet_webhook/pull/117) ([dhollinger](https://github.com/dhollinger))
- Add/fix redis dependency [\#116](https://github.com/voxpupuli/puppet_webhook/pull/116) ([dhollinger](https://github.com/dhollinger))
- Add new build tools and clean up some require statements [\#115](https://github.com/voxpupuli/puppet_webhook/pull/115) ([dhollinger](https://github.com/dhollinger))
- correct ruby requirements in README.md [\#110](https://github.com/voxpupuli/puppet_webhook/pull/110) ([bastelfreak](https://github.com/bastelfreak))
- Bump rack from 2.0.6 to 2.0.8 [\#109](https://github.com/voxpupuli/puppet_webhook/pull/109) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump puma from 3.12.1 to 3.12.2 [\#108](https://github.com/voxpupuli/puppet_webhook/pull/108) ([dependabot[bot]](https://github.com/apps/dependabot))
- Add build config and tools [\#107](https://github.com/voxpupuli/puppet_webhook/pull/107) ([dhollinger](https://github.com/dhollinger))
- Bump nokogiri from 1.10.2 to 1.10.5 [\#105](https://github.com/voxpupuli/puppet_webhook/pull/105) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update yard gem [\#103](https://github.com/voxpupuli/puppet_webhook/pull/103) ([dhollinger](https://github.com/dhollinger))

## [v2.0.0](https://github.com/voxpupuli/puppet_webhook/tree/v2.0.0) (2019-05-17)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.7.0...v2.0.0)

**Breaking changes:**

- Add sidekiq support with puppet and r10k libs [\#96](https://github.com/voxpupuli/puppet_webhook/pull/96) ([dhollinger](https://github.com/dhollinger))
- MVC Rework [\#83](https://github.com/voxpupuli/puppet_webhook/pull/83) ([dhollinger](https://github.com/dhollinger))

**Fixed bugs:**

- Fix a http body param bug [\#88](https://github.com/voxpupuli/puppet_webhook/pull/88) ([dhollinger](https://github.com/dhollinger))

**Closed issues:**

- Rename `stash` parser `bitbucket-server`, and reintroduce parser for stash users. [\#89](https://github.com/voxpupuli/puppet_webhook/issues/89)

**Merged pull requests:**

- Final updates before release [\#101](https://github.com/voxpupuli/puppet_webhook/pull/101) ([dhollinger](https://github.com/dhollinger))
- Added some more tests for the workers [\#100](https://github.com/voxpupuli/puppet_webhook/pull/100) ([dhollinger](https://github.com/dhollinger))
- Add Docker container and example docker-compose [\#99](https://github.com/voxpupuli/puppet_webhook/pull/99) ([dhollinger](https://github.com/dhollinger))
- Update the README in prep for 2.0.0 release [\#98](https://github.com/voxpupuli/puppet_webhook/pull/98) ([dhollinger](https://github.com/dhollinger))
- Remove unecessary puppet integration [\#97](https://github.com/voxpupuli/puppet_webhook/pull/97) ([dhollinger](https://github.com/dhollinger))
- Re-add user/pass support [\#95](https://github.com/voxpupuli/puppet_webhook/pull/95) ([dhollinger](https://github.com/dhollinger))
- Added authentication model, controller, and tasks [\#94](https://github.com/voxpupuli/puppet_webhook/pull/94) ([dhollinger](https://github.com/dhollinger))
- Remove gemnasium badge [\#93](https://github.com/voxpupuli/puppet_webhook/pull/93) ([alexjfisher](https://github.com/alexjfisher))
- Reinstate stash support in 2.x [\#91](https://github.com/voxpupuli/puppet_webhook/pull/91) ([alexjfisher](https://github.com/alexjfisher))
- Remove config file and have an example file in place [\#87](https://github.com/voxpupuli/puppet_webhook/pull/87) ([dhollinger](https://github.com/dhollinger))

## [v1.7.0](https://github.com/voxpupuli/puppet_webhook/tree/v1.7.0) (2019-02-18)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.6.2...v1.7.0)

**Breaking changes:**

- Restructure directory structure [\#74](https://github.com/voxpupuli/puppet_webhook/issues/74)
- Simplify Parser [\#71](https://github.com/voxpupuli/puppet_webhook/issues/71)

**Merged pull requests:**

- Re-enable `stash` \(post receive hook plugin\) support [\#90](https://github.com/voxpupuli/puppet_webhook/pull/90) ([alexjfisher](https://github.com/alexjfisher))

## [v1.6.2](https://github.com/voxpupuli/puppet_webhook/tree/v1.6.2) (2019-01-15)

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/v1.6.1...v1.6.2)

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

[Full Changelog](https://github.com/voxpupuli/puppet_webhook/compare/218b91ded31f8053cd6871677fdace831af49107...v0.1.0)

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



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
