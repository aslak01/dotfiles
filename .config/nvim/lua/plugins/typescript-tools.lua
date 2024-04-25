-- https://github.com/pmizio/typescript-tools.nvim/issues/248
return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "kyoh86/climbdir.nvim",
    },
    lazy = false,
    config = function()
        require("typescript-tools").setup {
            on_attach = function(client)
                -- Disable document formatting capabilities
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            root_dir = function(path)
                local marker = require("climbdir.marker")
                -- Determine the root directory based on the presence of package.json or node_modules
                return require("climbdir").climb(path,
                    marker.one_of(marker.has_readable_file("package.json"), marker.has_directory("node_modules")), {
                        -- Stop the plugin if any of the specified files/folders are found
                        halt = marker.one_of(
                            marker.has_readable_file("deno.json"),
                            marker.has_readable_file("deno.jsonc"),
                            marker.has_readable_file("import_map.json"),
                            marker.has_directory("denops")
                        ),
                    })
            end,
            single_file_support = false,
        }
    end,
}