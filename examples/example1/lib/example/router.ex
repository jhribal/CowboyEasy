defmodule Example.Router do 
	use CowboyEasy.Router


	host "localhost" do 
		path handler: __MODULE__

		path "/users/", handler: __MODULE__

		path :'_', handler: __MODULE__
	end

	def init(_, req, _opts) do
		{:ok, req, :undefined} 
	end

	def handle(req, state) do
		{path, req} = :cowboy_req.path(req)
		{:ok, req} = :cowboy_req.reply(200, [{"content-type", "text-plain"}], path, req)
		{:ok, req, state} 
	end

	def terminate(_reason, request, state) do
		:ok
	end

end