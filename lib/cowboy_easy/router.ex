defmodule CowboyEasy.Router do
	@moduledoc """
	Defines DSL for cowboy router definition.
	
	If `path` not specified, defaults to `"/"`.

	`opts` is always optional (default to `[]`).

	`handler` argument must be always defined.

	Default arguments:
	  - path: `"/"`
	  - opts: `[]`  

	Example:

		defmodule CustomRouter do
			use CowboyEasy.Router

			path HomeHandler # same as path("/", HomeHandler, []) or path(path: "/", handler: HomeHandler, opts: [])

			path "/users", UsersHandler # opts is optional

			path "/files", FileHandler, [path: "../files"]

			host "subdomain.domain.com" do
				path "/users", Subdomain.UsersHandler
				path handler: Subdomain.HomeHandler
			end 
			
		end
	"""

	defmacro __using__([]) do
		quote do
			import unquote(__MODULE__), only: :macros
			@router %{}
			@current_host :'_' 
			@before_compile unquote(__MODULE__)
		end
	end

	@doc false
	defmacro host(h, [do: body]) do
		quote do
			@current_host unquote(h)
			unquote(body)
			@current_host :'_'
		end 
	end

	@doc """
	args:
	  - path
	  - handler: handler module
	  - opts: options for handler
	"""
	defmacro path(args) when is_list(args) do
		quote do
			p = Keyword.get(unquote(args), :path, "/")
			o = Keyword.get(unquote(args), :opts, [])
			path(p, Keyword.fetch!(unquote(args), :handler), o) 
		end 
	end

	@doc """
	handler_and_opts:
	  - handler:
	  - opts:

	Example:

		path "/", handler: HomeHandler

	"""
	defmacro path(p, handler_and_opts) when is_list(handler_and_opts) do
		quote do
			path(unquote(p), Keyword.fetch!(unquote(handler_and_opts), :handler), Keyword.get(unquote(handler_and_opts), :opts, [])) 
		end 
	end

	@doc false
	defmacro path(p \\ "/", handler, opts \\ []) do
		quote do
			@router Map.update(@router, @current_host, [{unquote(p), unquote(handler), unquote(opts)}], 
				fn(paths) -> [{unquote(p), unquote(handler), unquote(opts)}|paths] end) 
		end
	end

	@doc false
	defmacro __before_compile__(_env) do
		quote do
			def router() do
				Enum.into(@router, []) 
			end 
		end 
	end 

end