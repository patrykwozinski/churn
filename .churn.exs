%{
  # You can have as many configs as you like in the `configs:` field.
  configs: [
    %{
      #
      # Run any config using `mix churn -C <name>`. If no config name is given
      # "default" is used.
      #
      name: "default",

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
  ]
}
