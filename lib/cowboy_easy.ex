defmodule CowboyEasy do
	@moduledoc """
	Used mainly for starting new cowboy server instance
	"""

	@doc """
	Starts new cowboy server instance with given router and options.

	Default options:
	  - port: `8080`
	  - number of acceptors: `100`
	  - name: `:cowboy_http_listener` 
	"""
	def start(module, opts \\ []) do

		:application.start(:ranch)
		:application.start(:cowlib)
		:application.start(:cowboy)

		port = Keyword.get(opts, :port, 8080)
		nbAcceptors = Keyword.get(opts, :acceptors, 100)
		name = Keyword.get(opts, :name, :cowboy_http_listener)

		:cowboy.start_http(name, nbAcceptors, [port: port], [env: [dispatch: :cowboy_router.compile(module.router())]])

	end

end
