# Churn [![Build Status](https://github.com/patrykwozinski/churn/workflows/CI/badge.svg)](https://github.com/patrykwozinski/churn/actions) [![Hex pm](https://img.shields.io/hexpm/v/churn.svg?style=flat)](https://hex.pm/packages/churn)

**Help discover a good refactoring candidates using cyclomatic complexity and frequency of editing files**

## Table of Contents
* [What Is it?](#what-is-it)
* [How to Use?](#how-to-use)
* [How to Install?](#how-to-install)
* [Similar Packages](#similar-packages)
* [How to release?](HOW_TO_RELEASE.md)

## What is it?
`churn` is a package that helps you identify `.ex` files in your project that could be good candidates for refactoring. It examines each Elixir file in the path it is provided and:
* Checks how many commits it has.
* Calculates the cyclomatic complexity.
* Creates a score based on these two values.

The results are displayed in a table:
![](asset/img/example.png)

## How to use
You can use some of existing flags to precise Churn results
```sh
--min-score-to-show (-s shortcut)

Example:
-s 2
```

```sh
--commit-since (-t shortcut)

Example:
-t "2 months ago"
```

```sh
--directories-to-scan (-d shortcut)

Example:
-d lib,test
```

```sh
--file-extensions [-e shortcut]

Example
-e "ex,exs"
```

```sh
--files-to-ignore [-i shortcut]

Example
-i "lib/churn/hello_world.ex"
```

```sh
--config [-c shortcut]

Example
-C foo/bar.exs
```

## How to install
The package can be installed by adding `churn` to your list of dependencies in `mix.exs` and then you need to copy `.churn.exs` [file](.churn.exs) into your project.

Update your `mix.exs`:
```elixir
def deps do
  [
    {:churn, "~> 0.1", only: :dev}
  ]
end
```

Copy and configure the `.churn.exs` file:
```elixir 
%{
  #
  # Minimum score to show in a table.
  #
  min_score_to_show: 0,

  #
  # Provide a human readable time to use git-log history for churn.
  #
  commit_since: "1 year ago",

  #
  # Describes output type for the Churn results
  #
  output_type: :console,

  #
  # Where to find a files to analyse and seeking for refactoring candidates.
  #
  directories_to_scan: ["lib"],

  #
  # Which extensions should be used for seeking project files.
  #
  file_extensions: ["ex", "exs"],

  #
  # Determines files should we ignore and protect from analysis.
  #
  files_to_ignore: []
}
```

Docs: [https://hexdocs.pm/churn](https://hexdocs.pm/churn).

## Similar Packages
* https://github.com/danmayer/churn (Ruby)
* https://github.com/chad/turbulence (Ruby)
* https://github.com/bmitch/churn-php (PHP)
