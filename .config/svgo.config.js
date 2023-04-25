module.exports = {
  multipass: true, // boolean. false by default
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
  ],
};
