# Agent notes for this Codespace

This repo is a GitHub Codespace for running the `temporal-cloud-setup` skill
(`.agents/skills/temporal-cloud-setup`). Follow that skill as written. These notes cover
only what's different about running it in a Codespace (Linux, in the cloud):

- **Skip the Preflight, Detect tools, and Install CLI steps (Phase 1, steps 2–4).** This
  Codespace was built with everything they check: the Temporal CLI and `temporal cloud`
  plugin, git, jq, every SDK's toolchain, and a writable config directory. The build
  verified all of it. This overrides the skill's "every step is required" rule for
  these three steps only. Don't render their gates and don't run their subcommands.
  - After the user picks an SDK, go straight to **Sign in**.
  - In the Phase 1 checklist, show those steps as done:
    `- [x] Tools detected — preinstalled in this Codespace` and
    `- [x] CLI installed — preinstalled in this Codespace`.
  - Use the default package manager for the SDK (Python: pip, TypeScript: npm) and
    don't ask which manager to use.
  - Every other step runs as the skill describes.
- **Sign-in in the browser version of Codespaces:** after the user signs in, their
  browser is redirected to `http://127.0.0.1:<port>/callback`, which can't reach this
  Codespace, so the page fails to load. When you present the sign-in go-ahead, add this
  line under the gate:

  > Using Codespaces in a browser tab? If the page fails to load after you sign in, copy its full address, open a new terminal, and run `finish-login '<address>'`.

  The user should never paste that address into the chat.
- **Clone the sample into the workspace root** (the skill's default path). `.gitignore`
  already excludes the cloned sample directories.
