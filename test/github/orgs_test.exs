defmodule Github.OrgsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "user_list!/2" do
    test "returns a list for current user" do
      use_cassette "orgs.user_list!" do
        response = %Github.Client{access_token: "access_token"} |> Github.Orgs.user_list!()

        assert response.status == 200
        assert response.body == []
      end
    end
  end

  describe "find!/2" do
    test "returns an organization" do
      use_cassette "orgs.find!" do
        response = %Github.Client{access_token: "access_token"} |> Github.Orgs.find!("WorkflowCI")

        assert response.status == 200
        assert response.body["name"] == "WorkflowCI"
      end
    end
  end
end
