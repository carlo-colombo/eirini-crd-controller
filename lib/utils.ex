defmodule Utils do
  def binding_context do
    filename = System.get_env("BINDING_CONTEXT_PATH")

    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Jason.decode(body, keys: :atoms),
         do: json |> Enum.at(0)
  end
end
