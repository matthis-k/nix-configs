return {
    {
        "David-Kunz/gen.nvim",
        keys = {
            { "<leader>cc", ":Gen Chat<CR>",                     desc = "Chat" },
            { "<leader>ce", ":Gen Change<CR>",                   desc = "Change",             mode = { "n", "v" } },
            { "<leader>cg", ":Gen Enhance_Grammar_Spelling<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
            { "<leader>cs", ":Gen Summarize<CR>",                desc = "Summarize",          mode = { "n", "v" } },
            { "<leader>cf", ":Gen Enhance_Code<CR>",             desc = "Enhance code",       mode = { "n", "v" } },
            { "<leader>cl", ":Gen Review_Code<CR>",              desc = "Code Review",        mode = { "n", "v" } },
        },
        opts = {
            model = "mistral",   -- The default model to use.
            host = "localhost",  -- The host running the Ollama service.
            port = "11434",      -- The port on which the Ollama service is listening.
            quit_map = "q",      -- set keymap for close the response window
            retry_map = "<c-r>", -- set keymap to re-send the current prompt
            init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
            -- Function to initialize Ollama
            command = function(options)
                local body = { model = options.model, stream = true }
                return "curl --silent --no-buffer -X POST http://" ..
                    options.host .. ":" .. options.port .. "/api/chat -d $body"
            end,
            display_mode = "split", -- The display mode. Can be "float" or "split".
            show_prompt = true,     -- Shows the prompt submitted to Ollama.
            show_model = true,      -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = false,  -- Never closes the window automatically.
            debug = false           -- Prints errors and the command which is run.
        }
    },
    {
        "jackMort/ChatGPT.nvim",
        enabled = false,
        keys = {
            { "<leader>cc", "<cmd>ChatGPT<CR>",                              desc = "ChatGPT" },
            { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>",           desc = "Edit with instruction",     mode = { "n", "v" } },
            { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>",        desc = "Grammar Correction",        mode = { "n", "v" } },
            { "<leader>ct", "<cmd>ChatGPTRun translate<CR>",                 desc = "Translate",                 mode = { "n", "v" } },
            { "<leader>ck", "<cmd>ChatGPTRun keywords<CR>",                  desc = "Keywords",                  mode = { "n", "v" } },
            { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>",                 desc = "Docstring",                 mode = { "n", "v" } },
            { "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>",                 desc = "Add Tests",                 mode = { "n", "v" } },
            { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>",             desc = "Optimize Code",             mode = { "n", "v" } },
            { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>",                 desc = "Summarize",                 mode = { "n", "v" } },
            { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>",                  desc = "Fix Bugs",                  mode = { "n", "v" } },
            { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>",              desc = "Explain Code",              mode = { "n", "v" } },
            { "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>",              desc = "Roxygen Edit",              mode = { "n", "v" } },
            { "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis", mode = { "n", "v" } },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        },
        opts = {
            yank_register = "+",
            edit_with_instructions = {
                diff = false,
                keymaps = {
                    close = "<C-c>",
                    accept = "<C-y>",
                    toggle_diff = "<C-d>",
                    toggle_settings = "<C-o>",
                    toggle_help = "<C-h>",
                    cycle_windows = "<Tab>",
                    use_output_as_input = "<C-i>",
                },
            },
            chat = {
                welcome_message = "May the AI be with you",
                loading_text = "Loading, please wait ...",
                question_sign = "", -- 🙂
                answer_sign = "ﮧ", -- 🤖
                border_left_sign = "",
                border_right_sign = "",
                max_line_length = 120,
                sessions_window = {
                    active_sign = "  ",
                    inactive_sign = "  ",
                    current_line_sign = "",
                    border = {
                        style = require("core.visuals").border,
                        text = {
                            top = " Sessions ",
                        },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
                keymaps = {
                    close = "<C-c>",
                    yank_last = "<C-y>",
                    yank_last_code = "<C-k>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    new_session = "<C-n>",
                    cycle_windows = "<Tab>",
                    cycle_modes = "<C-f>",
                    next_message = "<C-j>",
                    prev_message = "<C-k>",
                    select_session = "<Space>",
                    rename_session = "r",
                    delete_session = "d",
                    draft_message = "<C-r>",
                    edit_message = "e",
                    delete_message = "d",
                    toggle_settings = "<C-o>",
                    toggle_sessions = "<C-p>",
                    toggle_help = "<C-h>",
                    toggle_message_role = "<C-r>",
                    toggle_system_role_open = "<C-s>",
                    stop_generating = "<C-x>",
                },
            },
            popup_layout = {
                default = "center",
                center = {
                    width = "80%",
                    height = "80%",
                },
                right = {
                    width = "30%",
                    width_settings_open = "50%",
                },
            },
            popup_window = {
                border = {
                    highlight = "FloatBorder",
                    style = require("core.visuals").border,
                    text = {
                        top = " ChatGPT ",
                    },
                },
                win_options = {
                    wrap = true,
                    linebreak = true,
                    foldcolumn = "1",
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
                buf_options = {
                    filetype = "markdown",
                },
            },
            system_window = {
                border = {
                    highlight = "FloatBorder",
                    style = require("core.visuals").border,
                    text = {
                        top = " SYSTEM ",
                    },
                },
                win_options = {
                    wrap = true,
                    linebreak = true,
                    foldcolumn = "2",
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },
            popup_input = {
                prompt = "  ",
                border = {
                    highlight = "FloatBorder",
                    style = require("core.visuals").border,
                    text = {
                        top_align = "center",
                        top = " Prompt ",
                    },
                },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
                submit = "<C-Enter>",
                submit_n = "<Enter>",
                max_visible_lines = 20,
            },
            settings_window = {
                setting_sign = "  ",
                border = require("core.visuals").border,
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },
            help_window = {
                setting_sign = "  ",
                border = require("core.visuals").border,
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            },
            openai_params = {
                model = "gpt-3.5-turbo",
                frequency_penalty = 0,
                presence_penalty = 0,
                max_tokens = 300,
                temperature = 0,
                top_p = 1,
                n = 1,
            },
            openai_edit_params = {
                model = "gpt-3.5-turbo",
                frequency_penalty = 0,
                presence_penalty = 0,
                temperature = 0,
                top_p = 1,
                n = 1,
            },
            use_openai_functions_for_edits = false,
            actions_paths = {},
            show_quickfixes_cmd = "Trouble quickfix",
            predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
            highlights = {
                help_key = "@symbol",
                help_description = "@comment",
            },
        }
    }
}
