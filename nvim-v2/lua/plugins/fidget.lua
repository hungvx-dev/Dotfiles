require("fidget").setup({
	fmt = {
		leftpad = true, -- right-justify text in fidget box
		stack_upwards = true, -- list of tasks grows upwards
		max_width = 0, -- maximum width of the fidget box
		-- function to format fidget title
		fidget = function(fidget_name, spinner)
			return string.format("%s %s", spinner, fidget_name)
		end,
		-- function to format each task line
		task = function(task_name, message, percentage)
			return string.format(
				"%s%s [%s]",
				message,
				percentage and string.format(" (%s%%)", percentage) or "",
				task_name
			)
		end,
	},
})
