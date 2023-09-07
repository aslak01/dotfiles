module.exports = {
  // optimise until optimisations no longer decrease size
  multipass: true,
  plugins: [
    {
      name: "preset-default",
      params: {
        overrides: {
          removeViewBox: false,
        },
      },
    },
    "removeDimensions",
    "sortAttrs",
    "convertStyleToAttrs",
    "removeScriptElement",
    // {
    //   ...autocrop,
    //
    //   params: {
    //     autocrop: true,
    //     includeWidthAndHeightAttributes: false, // Same as enabling 'removeDimensions' plugin (and disabling 'removeViewBox' plugin).
    //
    //     removeClass: true, // Remove 'class' attribute if encountered.
    //     removeStyle: true, // Remove 'style'/'font-family' attribute if encountered.
    //     removeDeprecated: true, // Remove deprecated attributes - like <svg version/baseProfile>/etc.
    //
    //     setColor: "currentColor", // Replace any colors encountered with 'currentColor'.
    //     setColorIssue: "fail", // Fail if more than one color encountered.
    //   },
    // },
  ],
};
