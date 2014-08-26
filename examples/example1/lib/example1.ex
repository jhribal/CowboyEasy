defmodule Example do
	use Application

	def start(_, _) do
		CowboyEasy.start(Example.Router) 
	end

end
