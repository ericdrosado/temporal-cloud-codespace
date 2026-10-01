# Agent notes for this Codespace

This repo is a GitHub Codespace for running the `temporal-cloud-setup` skill
(`.agents/skills/temporal-cloud-setup`). Follow that skill as written. These notes cover
only what's different about running it in a Codespace (Linux, in the cloud):

- **The Temporal CLI and its `temporal cloud` plugin are preinstalled.** The skill's
  install step will report the CLI as present and skip the Homebrew update. That's
  expected: carry on with the installed CLI.
- **`brew-missing` from preflight is expected here.** Homebrew isn't used in this
  Codespace; don't ask the user to install it.
- **Sign-in in the browser version of Codespaces:** after the user signs in, their
  browser is redirected to `http://127.0.0.1:<port>/callback`, which can't reach this
  Codespace, so the page fails to load. When you present the sign-in go-ahead, add this
  line under the gate:

  > Using Codespaces in a browser tab? If the page fails to load after you sign in, copy its full address, open a new terminal, and run `finish-login '<address>'`.

  The user should never paste that address into the chat.
- **Clone the sample into the workspace root** (the skill's default path). `.gitignore`
  already excludes the cloned sample directories.
