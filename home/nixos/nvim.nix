{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # ===================== init.lua =====================
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # ===================== core/options.lua =====================
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Tabs & indentation
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      # Wrapping
      wrap = false;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;

      # Appearance
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      cursorcolumn = true;
      scrolloff = 8;
      sidescrolloff = 8;

      # Splits
      splitright = true;
      splitbelow = true;

      # Files
      swapfile = false;
      backup = false;
      undofile = true;

      # Clipboard
      clipboard = "unnamedplus";
      mouse = "a";
      mousescroll = "ver:1,hor:2";

      # Performance
      updatetime = 200;
      timeoutlen = 300;

      # Completion
      completeopt = "menu,menuone,noselect";
      pumheight = 10;
    };

    # ===================== core/keymaps.lua =====================
    keymaps = [
      # Better escape
      {
        mode = "i";
        key = "jk";
        action = "<Esc>";
      }

      # Clear search highlight
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }

      # Save / Quit
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save";
      }
      {
        mode = "n";
        key = "<leader>W";
        action = "<cmd>wa<CR>";
        options.desc = "Save all";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
      }

      # Window navigation
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }

      # Window resize
      { mode = "n"; key = "<C-Up>";    action = "<cmd>resize +2<CR>"; }
      { mode = "n"; key = "<C-Down>";  action = "<cmd>resize -2<CR>"; }
      { mode = "n"; key = "<C-Left>";  action = "<cmd>vertical resize -2<CR>"; }
      { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<CR>"; }

      # Buffer navigation
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<CR>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }

      # Move lines
      { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<CR>=="; }
      { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<CR>=="; }
      { mode = "v"; key = "<A-j>"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "<A-k>"; action = ":m '<-2<CR>gv=gv"; }

      # Keep indent selection
      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }

      # New split
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vsplit<CR>";
        options.desc = "Vertical split";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<cmd>split<CR>";
        options.desc = "Horizontal split";
      }

      # ===== plugins/editor.lua: flash.nvim =====
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "<CMD>lua require('flash').jump()<CR>";
        options.desc = "Flash jump";
      }
      {
        mode = [ "n" "x" "o" ];
        key = "S";
        action = "<CMD>lua require('flash').treesitter()<CR>";
        options.desc = "Flash treesitter";
      }
      {
        mode = "o";
        key = "r";
        action = "<CMD>lua require('flash').remote()<CR>";
        options.desc = "Flash remote";
      }
      {
        mode = [ "o" "x" ];
        key = "R";
        action = "<CMD>lua require('flash').treesitter_search()<CR>";
        options.desc = "Flash treesitter search";
      }

      # ===== plugins/filetree.lua: nvim-tree =====
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle file tree";
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>NvimTreeFocus<CR>";
        options.desc = "Focus file tree";
      }

      # ===== plugins/formatting.lua: conform =====
      {
        mode = "n";
        key = "<leader>cf";
        action = "<CMD>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        options.desc = "Format buffer";
      }

      # ===== plugins/fzf.lua: fzf-lua =====
      {
        mode = "n";
        key = "<leader>ff";
        action = "<CMD>lua require('fzf-lua').files()<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<CMD>lua require('fzf-lua').live_grep()<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<CMD>lua require('fzf-lua').buffers()<CR>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<CMD>lua require('fzf-lua').oldfiles()<CR>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = "<CMD>lua require('fzf-lua').lsp_document_symbols()<CR>";
        options.desc = "Document symbols";
      }
      {
        mode = "n";
        key = "<leader>fS";
        action = "<CMD>lua require('fzf-lua').lsp_workspace_symbols()<CR>";
        options.desc = "Workspace symbols";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<CMD>lua require('fzf-lua').diagnostics_document()<CR>";
        options.desc = "Document diagnostics";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<CMD>lua require('fzf-lua').grep_curbuf()<CR>";
        options.desc = "Search in buffer";
      }
    ];

    # ===================== core/autocmds.lua: augroups =====================
    autoGroups = {
      highlight_yank = { clear = true; };
      resize_splits = { clear = true; };
      filetype_indent = { clear = true; };
      markdown_emphasis = { clear = true; };
      close_with_q = { clear = true; };
      crosshair = { clear = true; };
    };

    # ===================== core/autocmds.lua (simple parts) =====================
    autoCmd = [
      # Highlight yanked region briefly
      {
        event = [ "TextYankPost" ];
        group = "highlight_yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
          end
        '';
      }

      # Equalise splits when the terminal is resized
      {
        event = [ "VimResized" ];
        group = "resize_splits";
        callback.__raw = ''
          function() vim.cmd("tabdo wincmd =") end
        '';
      }

      # 2-space indent for common config/markup filetypes
      {
        event = [ "FileType" ];
        group = "filetype_indent";
        pattern = [ "lua" "json" "jsonc" "css" "toml" "yaml" "markdown" "html" ];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
          end
        '';
      }

      # Markdown: quick bold / italic helpers (localleader = "\")
      {
        event = [ "FileType" ];
        group = "markdown_emphasis";
        pattern = "markdown";
        callback.__raw = ''
          function(ev)
            local o = { buffer = ev.buf, silent = true }
            vim.keymap.set("x", "<localleader>b", "c**<C-r>\"**<Esc>",
              vim.tbl_extend("force", o, { desc = "Bold selection" }))
            vim.keymap.set("n", "<localleader>b", "viwc**<C-r>\"**<Esc>",
              vim.tbl_extend("force", o, { desc = "Bold word" }))
            vim.keymap.set("x", "<localleader>i", "c*<C-r>\"*<Esc>",
              vim.tbl_extend("force", o, { desc = "Italic selection" }))
            vim.keymap.set("n", "<localleader>i", "viwc*<C-r>\"*<Esc>",
              vim.tbl_extend("force", o, { desc = "Italic word" }))
          end
        '';
      }

      # Close certain utility windows with just q
      {
        event = [ "FileType" ];
        group = "close_with_q";
        pattern = [ "help" "man" "qf" "checkhealth" "lspinfo" ];
        callback.__raw = ''
          function(ev)
            vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
          end
        '';
      }

      # Hide crosshair in insert mode; restore on leaving
      {
        event = [ "InsertEnter" ];
        group = "crosshair";
        callback.__raw = ''
          function()
            vim.opt.cursorline   = false
            vim.opt.cursorcolumn = false
          end
        '';
      }
      {
        event = [ "InsertLeave" ];
        group = "crosshair";
        callback.__raw = ''
          function()
            vim.opt.cursorline   = true
            vim.opt.cursorcolumn = true
          end
        '';
      }
    ];

    # ===================== plugins =====================
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true;
        terminal_colors = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
      };
    };

    plugins = {
      # ---- editor ----
      flash.enable = true;

      mini-ai.enable = true;
      mini-pairs.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add = { text = "▎"; };
          change = { text = "▎"; };
          delete = { text = ""; };
          topdelete = { text = ""; };
          changedelete = { text = "▎"; };
        };
      };

      # ---- completion: blink.cmp ----
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "default";
            "<C-Space>" = [ "show" "fallback" ];
            "<CR>" = [ "accept" "fallback" ];
            "<Tab>" = [ "select_next" "snippet_forward" "fallback" ];
            "<S-Tab>" = [ "select_prev" "snippet_backward" "fallback" ];
            "<C-n>" = [ "select_next" "fallback" ];
            "<C-p>" = [ "select_prev" "fallback" ];
            "<C-e>" = [ "cancel" "fallback" ];
          };
          completion = {
            trigger = {
              show_on_keyword = false;
              show_on_trigger_character = true;
              show_on_insert_on_trigger_character = true;
            };
            documentation = {
              auto_show = false;
              auto_show_delay_ms = 500;
              window = { border = "rounded"; };
            };
            list = { max_items = 12; };
            menu = { border = "rounded"; };
          };
          signature = { enabled = false; };
          sources = {
            default = [ "lsp" "path" "snippets" "buffer" ];
          };
        };
      };

      # ---- LSP ----
      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gi" = "implementation";
            "K" = "hover";
            "<C-k>" = "signature_help";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
          diagnostic = {
            "<leader>e" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
        };
        servers = {
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                diagnostics = { globals = [ "vim" ]; };
                workspace = { checkThirdParty = false; };
                telemetry = { enable = false; };
              };
            };
          };
          clangd = {
            enable = true;
            cmd = [
              "clangd"
              "--background-index"
              "--clang-tidy"
              "--header-insertion=never"
              "--completion-style=detailed"
              "--inlay-hints=false"
            ];
          };
          pyright = {
            enable = true;
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic";
                  autoSearchPaths = true;
                  useLibraryCodeForTypes = true;
                };
              };
            };
          };
          taplo.enable = true;
          texlab = {
            enable = true;
            settings = {
              texlab = {
                build = { onSave = false; };
                chktex = { onEdit = false; onOpenAndSave = false; };
              };
            };
          };
        };
      };

      lazydev = {
        enable = true;
        settings.library = [
          {
            path = "\${3rd}/luv/library";
            words = [ "vim%.uv" ];
          }
        ];
      };

      # ---- treesitter ----
      treesitter = {
        enable = true;
        settings.ensure_installed = [
          "bash" "c" "lua" "vim" "vimdoc"
          "python" "markdown" "markdown_inline"
          "json" "toml" "yaml" "css" "latex"
        ];
      };

      # ---- filetree ----
      nvim-tree = {
        enable = true;
        settings = {
          view = {
            width = 30;
            side = "left";
          };
          renderer = {
            group_empty = true;
            highlight_git = true;
            indent_markers = { enable = true; };
          };
          git = {
            enable = true;
            ignore = false;
          };
          actions.open_file = {
            quit_on_open = false;
          };
          filters.dotfiles = false;
        };
      };

      # ---- formatting: conform.nvim ----
      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          python = [ "ruff_format" ];
          lua = [ "stylua" ];
          toml = [ "taplo" ];
        };
      };

      # ---- fzf-lua ----
      fzf-lua = {
        enable = true;
        settings = {
          winopts = {
            border = "rounded";
            preview = { border = "border"; };
          };
          keymap.fzf = {
            j = "down";
            k = "up";
            "ctrl-j" = "down";
            "ctrl-k" = "up";
            "ctrl-d" = "preview-page-down";
            "ctrl-u" = "preview-page-up";
          };
        };
      };

      # ---- ui ----
      web-devicons.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "tokyonight";
            component_separators = "|";
            section_separators = "";
            globalstatus = true;
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ { filename.path = 1; } ];
            lualine_x = [ "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };

      mini-starter = {
        enable = true;
        # 完全自定义的 starter 放 extraConfigLuaPost 里覆盖
      };

      # ---- lang ----
      clangd-extensions = {
        enable = true;
        settings.inlay_hints = {
          inline = false;
          show_parameter_hints = false;
          parameter_hints_prefix = "";
          other_hints_prefix = "";
        };
      };

      vimtex = {
        enable = true;
        settings = {
          view_method = "zathura";
          compiler_latexmk = {
            build_dir = "";
            continuous = 1;
            executable = "latexmk";
            options = [
              "-xelatex"
              "-verbose"
              "-file-line-error"
              "-synctex=1"
              "-interaction=nonstopmode"
            ];
          };
          view_forward_search_on_start = false;
          quickfix_open_on_warning = 0;
        };
      };
    };

    # ===================== complex lua (highlights / fcitx5 / LspAttach / nvim-tree autoclose / mini.starter) =====================
    extraConfigLua = ''
      -- ===== core/options.lua: diagnostics =====
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
        },
      })

      -- ===== core/autocmds.lua: fcitx5 =====
      if vim.fn.executable("fcitx5-remote") == 1 then
        local fcitx5 = vim.api.nvim_create_augroup("fcitx5", { clear = true })
        local saved_im = 1

        local function im_off()
          vim.fn.system("fcitx5-remote -c")
        end

        local function im_save_and_off()
          saved_im = tonumber(vim.fn.system("fcitx5-remote")) or 1
          im_off()
        end

        local function im_restore()
          if saved_im == 2 then
            vim.fn.system("fcitx5-remote -o")
          end
        end

        vim.api.nvim_create_autocmd("InsertEnter", {
          group = fcitx5,
          callback = im_restore,
        })

        vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
          group = fcitx5,
          callback = im_save_and_off,
        })

        vim.api.nvim_create_autocmd("ModeChanged", {
          group = fcitx5,
          pattern = { "*:n", "*:no", "*:ns" },
          callback = im_off,
        })

        local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
        vim.keymap.set("i", "jk", function()
          vim.fn.system("fcitx5-remote -c")
          vim.api.nvim_feedkeys(esc, "n", false)
        end, { silent = true, desc = "Exit insert + disable IME" })
      end

      -- ===== plugins/lsp.lua: LspAttach tweaks =====
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          end
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      -- ===== plugins/filetree.lua: nvim-tree autoclose =====
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.bo[bufnr].filetype == "NvimTree" then
            vim.api.nvim_create_autocmd("WinClosed", {
              buffer = bufnr,
              callback = function()
                vim.schedule(function()
                  if #vim.api.nvim_list_wins() == 1 then
                    local last = vim.api.nvim_list_wins()[1]
                    local buf  = vim.api.nvim_win_get_buf(last)
                    if vim.bo[buf].filetype == "NvimTree" then
                      vim.cmd("quit")
                    end
                  end
                end)
              end,
            })
          end
        end,
      })
    '';

    # ===== core/highlights.lua + mini.starter (需要覆盖模块 setup) =====
    extraConfigLuaPost = ''
      -- ===== core/highlights.lua: bold syntax =====
      local code_bold = {
        "@type.builtin",
        "@keyword.modifier",
        "@keyword.type",
      }
      local markup_bold = {
        "@markup.strong",
      }
      local function add_bold(group)
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if not ok then return end
        hl = hl or {}
        hl.bold = true
        hl.default = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
      local function apply_bold()
        for _, g in ipairs(code_bold) do add_bold(g) end
        for _, g in ipairs(markup_bold) do add_bold(g) end
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("bold_syntax", { clear = true }),
        callback = apply_bold,
      })
      apply_bold()

      -- ===== plugins/ui.lua: mini.starter (fully custom, override module setup) =====
      local starter = require("mini.starter")

      local indent = "       "
      local HINT_COL = 30
      local function act(icon, label, hint, action_val, sec)
        local used = vim.fn.strwidth(icon) + 2 + vim.fn.strwidth(label)
        local pad  = string.rep(" ", math.max(4, HINT_COL - used))
        return {
          section = sec or "nav",
          name    = indent .. icon .. "  " .. label .. pad .. hint,
          action  = action_val,
        }
      end

      local function sections_as_spacers(content)
        local out = {}
        for _, line in ipairs(content) do
          local is_sec = false
          for _, unit in ipairs(line) do
            if unit.type == "section" then is_sec = true; break end
          end
          if is_sec then
            table.insert(out, { { type = "empty", string = "" } })
          else
            table.insert(out, line)
          end
        end
        return out
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.keymap.set("n", "j", "<Cmd>lua MiniStarter.update_current_item('next')<CR>",
            { buffer = buf, nowait = true, silent = true })
          vim.keymap.set("n", "k", "<Cmd>lua MiniStarter.update_current_item('prev')<CR>",
            { buffer = buf, nowait = true, silent = true })
        end,
      })

      starter.setup({
        evaluate_single = true,

        header = table.concat({
          "",
          "██╗  ██╗ ██████╗ ██████╗ ██╗███████╗ ██████╗ ███╗   ██╗",
          "██║  ██║██╔═══██╗██╔══██╗██║╚══███╔╝██╔═══██╗████╗  ██║",
          "███████║██║   ██║██████╔╝██║  ███╔╝ ██║   ██║██╔██╗ ██║",
          "██╔══██║██║   ██║██╔══██╗██║ ███╔╝  ██║   ██║██║╚██╗██║",
          "██║  ██║╚██████╔╝██║  ██║██║███████╗╚██████╔╝██║ ╚████║",
          "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝",
          "",
          "",
        }, "\n"),

         items = {
          act("",  "Find File",    "SPC f f",  "lua require('fzf-lua').files()",     "nav"),
          act("",  "New File",     "SPC f n",  "enew",                               "nav"),
          act("󰋚",  "Recent Files", "SPC f r",  "lua require('fzf-lua').oldfiles()",  "nav"),
          act("󰍉",  "Live Grep",    "SPC f g",  "lua require('fzf-lua').live_grep()", "nav"),
          act("",  "Config",       "SPC f c",  function()
            require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
          end, "tools"),
          act("󰒲",  "Lazy",         ":Lazy  ",  "Lazy",                               "tools"),
          act("󰩈",  "Quit",         "q      ",  "qa",                                 "tools"),
        },

              content_hooks = {
          sections_as_spacers,
          starter.gen_hook.adding_bullet("  > "),
          starter.gen_hook.aligning("center", "center"),
        },

        footer = "NixOS + Nixvim",
      })
    '';
  };
}
