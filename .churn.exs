%{
  #
  # Minimum score to show in the output table.
  #
  min_score_to_show: 0,

  #
  # Specify when to look for commits. (This string is passed to `git rev-list
  # --since [value]`, so any human-readable string it understands is
  # acceptable.)
  #
  commit_since: "1 year ago",

  #
  # Describes output type for the Churn results
  #
  output_type: :console,

  #
  # Where to find files to analyse and look for refactoring candidates.
  #
  directories_to_scan: ["lib", "apps/*/lib"],

  #
  # Which extensions should be used for seeking files to analyse.
  #
  file_extensions: ["ex", "exs"],

  #
  # Determines files should we ignore and protect from analysis.
  #
  files_to_ignore: []
}
