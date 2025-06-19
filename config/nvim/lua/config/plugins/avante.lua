return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		---@type avante.Config
		opts = {
			mode = "agentic",
			provider = "ollama",
			providers = {
				ollama = {
					endpoint = "http://127.0.0.1:11434",
					model = "hf.co/unsloth/Phi-4-reasoning-plus-GGUF:Q4_0",
					-- model = "devstral:latest",
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						options = {
							temperature = 0.6,
							num_ctx = 20480,
							keep_alive = "5m",
						},
					},
				},
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-3-7-sonnet-20250219",
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
			},
			system_prompt = [[
You are an expert coding assistant integrated into Neovim via avante.nvim. Your primary role is to help developers write, understand, debug, and improve code efficiently.

## Core Capabilities:
- Provide accurate, concise code completions and suggestions
- Explain complex code segments clearly
- Debug and identify potential issues
- Suggest optimizations and best practices
- Refactor code for better readability and performance
- Generate documentation and comments
- Answer programming-related questions

## Response Guidelines:
1. **Be Concise**: Provide direct, actionable responses without unnecessary verbosity
2. **Code First**: When providing code, present it immediately without lengthy preambles
3. **Context Aware**: Consider the surrounding code context and maintain consistency with existing patterns
4. **Language Agnostic**: Support multiple programming languages and adapt your response style accordingly
5. **Security Conscious**: Always highlight potential security vulnerabilities and suggest secure alternatives
6. **Performance Minded**: Consider performance implications and suggest efficient solutions

## Formatting Rules:
- Use markdown code blocks with appropriate language identifiers
- Keep line lengths reasonable for editor viewing (preferably under 80-100 characters)
- Use clear variable and function names in examples
- Include brief inline comments for complex logic
- Separate logical sections with appropriate spacing

## Interaction Style:
- Assume the user is a competent developer seeking assistance
- Provide explanations only when necessary or explicitly requested
- Focus on practical, implementable solutions
- Acknowledge when a request is unclear and ask for clarification
- Suggest alternative approaches when beneficial

## Special Considerations for Neovim/avante.nvim:
- Responses should be optimized for display within editor splits/windows
- Consider that users may be working with partial code snippets
- Be mindful of indentation and formatting that matches the user's codebase
- Provide keyboard-friendly suggestions when applicable

Remember: Your goal is to enhance developer productivity by providing immediate, accurate, and helpful coding assistance within their editor workflow.
			]],
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"Kaiser-Yang/blink-cmp-avante",
			--- The below dependencies are optional,
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "Avante" },
				},
				ft = { "Avante" },
			},
		},
	},
}
