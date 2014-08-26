# CowboyEasy

> CowboyEasy aims to make Cowboy web server easier for ppl using Elixir.

## CowboyEasy.Router

Allows easily setup router definition.

**Cowboy:**

	router = [{:'_', [
					{"/", HomeHandler, []},
					{"/file", FileHandler, [path: "../files"]}]}, 
			  {"subdomain.domain.com", [
			  		{"/", Subdomain.HomeHandler, []}]}]

	router = :cowboy.compile(router)

	:cowboy.start_http(:cowboy_http_listener, 100, [port: 8080], [env: [dispatch: router]])

**CowboyEasy:**
	
	defmodule Router do 
		use CowboyEasy

		path HomeHandler
		path "/file", FileHandler, path: "../files"

		host "subdomain.domain.com" do
			path Subdomain.HomeHandler 
		end 

	end

	CowboyEasy.start(Router)

## LICENSE

MIT
