return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  settings = {
    vue = {
      autoInsert = {
        bracketSpacing = true,
        dotValue = false,
      },
      codeActions = {
        askNewComponentName = true,
        enabled = true,
      },
      codeLens = {
        enabled = true
      },
      complete = {
        casing = {
          props = "autoKebab",
          tags  = "autoPascal"
        },
        defineAssignment = true
      },
      doctor = {
        status = true
      },
      format = {
        script = {
          initialIndent = false
        },
        style = {
          initialIndent = false
        },
        template = {
          initialIndent = true
        },
        wrapAttributes = "auto"
      },
      inlayHints = {
        destructuredProps    = false,
        inlineHandlerLeading = false,
        missingProps         = false,
        optionsWrapper       = false,
        vBindShorthand       = false,
      },
      server = {
        compatibleExtensions = {},
        hybridMode = "auto",
        includeLanguages = { "vue" },
        -- maxOldSpaceSize
      },
      splitEditors = {
        icon = false,
        layout = {
          left  = { "script", "scriptSetup", "styles" },
          right = { "template", "customBlocks" },
        },
        trace = {
          server = "off"
        }
      },
      updateImportsOnFileMove = {
        enabled = true
      }
    }
  }
}
