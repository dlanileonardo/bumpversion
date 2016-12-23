# Bumpversion

Simple command to Bump version your project in shell.

- Bump multiple files version in your project
- Git operations like commit, tag and push
- Customizables Hooks

# Screencast

[![asciicast](https://asciinema.org/a/0137fm32a947bqqmg5r1eqt8p.png)](https://asciinema.org/a/0137fm32a947bqqmg5r1eqt8p)

# Code Status

Service | Status
--------|----------
Issues Ready to Work|[![Waffle.io](https://img.shields.io/waffle/label/dlanileonardo/bumpversion/in%20progress.svg?maxAge=2592000&style=flat-square)](https://waffle.io/dlanileonardo/bumpversion)
Gems Version|[![Gem](https://img.shields.io/gem/v/bumpversion.svg?maxAge=2592000&style=flat-square)](http://badge.fury.io/rb/bumpversion)
Code Climate|[![Code Climate](https://img.shields.io/codeclimate/github/kabisaict/flow.svg?maxAge=2592000&style=flat-square)](https://codeclimate.com/github/dlanileonardo/bumpversion)
Coverage|[![Code Climate](https://img.shields.io/codeclimate/coverage/github/dlanileonardo/bumpversion.svg?maxAge=2592000&style=flat-square)](https://codeclimate.com/github/dlanileonardo/bumpversion/coverage)
Build Status|[![Travis](https://img.shields.io/travis/dlanileonardo/bumpversion.svg?maxAge=2592000&style=flat-square)](https://travis-ci.org/dlanileonardo/bumpversion)
Dependencies|[![Gemnasium](https://img.shields.io/gemnasium/dlanileonardo/bumpversion.svg?maxAge=2592000&style=flat-square)]()

## Installation

    $ gem install bumpversion

## Usage

1. Create .bumpversion.cfg file in project root folder.

  Example:

  ```
  [bumpversion]
  current-version=33.0.2
  pre-commit-hooks=github_changelog_generator --future-release %{new_version}
  git-extra-add=CHANGELOG.md
  git-commit=yes
  git-tag=yes
  git-push=yes
  ```

2. Run command with argument [major, minor, patch]:

  ```
  $ bumpversion --part patch
  ```

3. Enjoy

## Options

Options can be passed in arguments with -- or in .cfg file wihout --.

Option|Description
--------|----------
part|The part of the version to increase, [major, minor, patch] (default: minor)
file|The file that will be modified can be multi-files separated by comma. <br /> Example: VERSION, GEMNAME.gemspec, version.rb (Default: VERSION)
config-file|The file contains config this program (default: .bumpversion.cfg)
current-version|The current version of the software package before bumping
new-version| The version of the software package after the increment. <br /> If not given will be automatically determined.
git-commit|Whether to create a commit using Git.
git-tag|Whether to create a tag, that is the new version, prefixed with the character "v". If you are using git
git-push|Pushes Tags and Commit to origin Git
git-user|Name from User to Create Commit (default: Auto Bump)
git-email|Email from User to Create Email (default: auto@bump.io)
git-extra-add|Extra files to add in git commit (default: )
pre-commit-hooks|Call sh commands before commits after Bumpversion separated by ;
pos-commit-hooks|Call sh commands after commits separated by ;

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
