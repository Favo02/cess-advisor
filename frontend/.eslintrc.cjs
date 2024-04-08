/*eslint-env node*/

module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:react/jsx-runtime",
    "plugin:react-hooks/recommended"
  ],
  ignorePatterns: ["dist", "**/components/ui"],
  parserOptions: { ecmaVersion: "latest", sourceType: "module" },
  settings: { react: { version: "18.2" } },
  plugins: ["react-refresh"],
  rules: {
    "react-refresh/only-export-components": [
      "warn",
      { allowConstantExport: true }
    ],
    "arrow-body-style": ["error", "as-needed"],
    "arrow-spacing": [
      "error",
      {
        "after": true,
        "before": true
      }
    ],
    "camelcase": "error",
    "eol-last": 1,
    "eqeqeq": "error",
    "indent": ["error", 2],
    "key-spacing": [
      "error",
      {
        "afterColon": true,
        "beforeColon": false
      }
    ],
    "linebreak-style": ["error", "unix"],
    "no-trailing-spaces": "error",
    "object-curly-spacing": ["error", "always"],
    "quotes": ["error", "double"],
    "react/jsx-tag-spacing": [
      "error",
      {
        "afterOpening": "never",
        "beforeClosing": "never",
        "beforeSelfClosing": "always",
        "closingSlash": "never"
      }
    ],
    "react/react-in-jsx-scope": "off",
    "react/self-closing-comp": [
      "error",
      {
        "component": true,
        "html": true
      }
    ],
    "semi": ["error", "never"],
    "comma-dangle": ["error", "never"],
    "react-hooks/exhaustive-deps": "error",
    "react/prop-types": "off"
  }
}
