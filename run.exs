defmodule Main do
  def main(["--config"]) do
    %{
      onKubernetesEvent: [
        %{name: "OnCreateDeleteNamespace", kind: "namespace", event: ["add", "delete"]}
      ]
    }
    |> Jason.encode!()
    |> IO.puts()
  end

  def main([]) do
    IO.inspect("dothings")

    System.get_env("BINDING_CONTEXT_PATH")
    |> IO.inspect()
  end
end

Main.main(System.argv())
