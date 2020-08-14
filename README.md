# Bumpversion

Simple command to Bump version your project in shell.

- Bump multiple files version in your project
- Git operations like commit, tag and push
- Customizables Hooks

# Screencast

[![asciicast](https://asciinema.org/a/c1o6gpp63xggu3w49n3xzte65.png)](https://asciinema.org/a/c1o6gpp63xggu3w49n3xzte65)

# Code Status

Service | Status
--------|----------
Gems Version|[![Gem](https://img.shields.io/gem/v/bumpversion.svg?maxAge=2592000&style=flat-square)](http://badge.fury.io/rb/bumpversion)
Build Status|[![CI](https://github.com/dlanileonardo/bumpversion/workflows/CI/badge.svg)](https://github.com/dlanileonardo/bumpversion/actions?query=workflow%3ACI)


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
