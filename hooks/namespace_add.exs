defmodule Main do
  import Kubectl

  def main(["--config"]) do
    %{
      onKubernetesEvent: [
        %{name: "Long running process creation/deletion", kind: "lrp", event: ["add", "delete"]}
      ]
    }
    |> Jason.encode!()
    |> IO.puts()
  end

  def main([]) do
    binding_context()
    |> IO.inspect()
    |> do_stuff
  end

  defp do_stuff(%{
         resourceEvent: "add",
         resourceKind: "namespace",
         resourceName: resourceName
       }) do
    {:ok, resp} = kubectl(describe: {"namespace", resourceName})
    IO.puts(resp)
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

  defp binding_context do
    filename = System.get_env("BINDING_CONTEXT_PATH")

    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body, keys: :atoms),
         do: json |> Enum.at(0)
  end
end

Main.main(System.argv())
