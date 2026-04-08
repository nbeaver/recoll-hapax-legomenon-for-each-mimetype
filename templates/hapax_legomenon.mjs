import globals from "globals";
import { defineConfig } from "eslint/config";

// ${unique_word}
export default defineConfig([
  { files: ["**/*.js"], languageOptions: { sourceType: "script" } },
  { files: ["**/*.{js,mjs,cjs}"], languageOptions: { globals: globals.browser } },
]);
