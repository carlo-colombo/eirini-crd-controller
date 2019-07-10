defmodule LRPLifecycle do
  import Kubectl
  require Utils

  def main(["--config"]) do
    %{
      onKubernetesEvent: [
        %{
          name: "Long running process creation/deletion",
          kind: "lrp",
          event: ["add", "delete"]
        }
      ]
    }
    |> Jason.encode!()
    |> IO.puts()
  end

  def main([]) do
    Utils.binding_context()
    |> IO.inspect()
    |> do_stuff
  end

  defp do_stuff(%{
         resourceEvent: "add",
         resourceKind: "lrp",
         resourceName: resourceName
       }) do
    {:ok, resp} = kubectl(get: {"lrp", resourceName})
    IO.puts(resp)
    IO.puts("lrp/#{resourceName} created")
  end

  defp do_stuff(_), do: IO.puts("No match")
end
