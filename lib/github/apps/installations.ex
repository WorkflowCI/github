defmodule Github.Apps.Installations do
  import Github.Client

  @list_repos_default_options %{
    page: 1,
    per_page: 30
  }

  @moduledoc """
    GitHub Apps [Installations](https://developer.github.com/v3/apps/installations/).
  """

  @doc """
  List repositories available for the Installation

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Apps.Installations.list_repos!(page: 1, per_page: 30)
      %Github.Client.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        ...
      }
  """
  def list_repos!(github_client, options \\ []) do
    opts = Enum.into(options, @list_repos_default_options)

    get!(
      "https://api.github.com/installation/repositories?per_page=#{opts.per_page}&page=#{
        opts.page
      }",
      [
        {"Authorization", "token #{github_client.access_token}"},
        {"Accept", "application/vnd.github.machine-man-preview+json"}
      ]
    )
  end

  @doc """
  Get an installation

  ## Example

      iex> client = %Github.Client{jwt_token: "jwt_token"}

      iex> client |> Github.Apps.Installations.find!(12345)
      %Github.Client.Response{
        body: %{"id" => 12345, ...},
        status: 200,
        ...
      }
  """
  def find!(github_client, installation_id) do
    get!(
      "https://api.github.com/app/installations/#{installation_id}",
      [
        {"Authorization", "Bearer #{github_client.jwt_token}"},
        {"Accept", "application/vnd.github.machine-man-preview+json"}
      ]
    )
  end
end
