defmodule Uderzo.Mixfile do
  use Mix.Project

  def project do
    [ app: :uderzo,
      version: version(),
      build_path: "_build",
      config_path: "config/config.exs",
      deps_path: "deps",
      lockfile: "mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      name: "Uderzo",
      source_url: "https://github.com/cdegroot/uderzo_poncho",
      make_env: make_env(),
      compilers: Mix.compilers ++ [:clixir, :elixir_make]
    ]
  end

  def version, do: "0.2.0"

  def docs do
    [ extras: [
        ]]
  end

  def application do
    [extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do

    [clixir_dep(Mix.env),
     {:nanovg, github: "memononen/nanovg", tag: "6fa3b3d", app: false},
     {:ex_doc, "~> 0.16", runtime: false},
     {:mix_test_watch, "~> 0.3", only: [:dev, :test]}]
  end

  def clixir_dep(:prod), do: {:clixir, "~> #{version()}"}
  def clixir_dep(_), do: {:clixir, path: "../clixir"}

  defp description() do
    "A native UI package for Elixir employing NanoVG/OpenGL ES"
  end

  defp make_env() do
    case System.get_env("ERL_EI_INCLUDE_DIR") do
      nil ->
        %{
          "ERL_EI_INCLUDE_DIR" => "#{:code.root_dir()}/usr/include",
          "ERL_EI_LIBDIR" => "#{:code.root_dir()}/usr/lib",
          "MIX_ENV" => "#{Mix.env}"}
      _ ->
        %{}
    end
  end

  defp package() do
    [ # These are the default files included in the package
      files: [
        "lib",
        "c_src",
        "priv/*.ttf",
        "mix.exs",
        "README*",
        "LICENSE*"],
      maintainers: ["Cees de Groot"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/cdegroot/uderzo_poncho"}]
  end
end
