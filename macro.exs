defmodule Kubectl do
  def kubectl(describe: {object, name}) do
    {res, 0} = System.cmd("kubectl", ["describe", object, name])

    res
  end
end
