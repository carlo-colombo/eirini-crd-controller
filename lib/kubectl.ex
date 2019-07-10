defmodule Kubectl do
  def kubectl(describe: {object, name}), do: _kubectl(["describe", object, name])
  def kubectl(get: {object, name}), do: _kubectl(["get", object, name])

  defp _kubectl(args) do
    case System.cmd("kubectl", args) do
      {res, 0} -> {:ok, res}
      {res, _} -> {:error, res}
    end
  end
end
