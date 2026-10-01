# Temporal Cloud setup in a Codespace

Set up Temporal Cloud and run your first Workflow from your browser. Nothing to install on your computer.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/ericdrosado/temporal-cloud-codespace)

An AI agent runs the setup for you, entirely inside the Codespace. It signs you in to Temporal Cloud, creates a namespace and an API key, downloads a sample app in the SDK you pick, and runs a money-transfer Workflow on Cloud. Then it breaks the transfer on purpose so you can watch Temporal recover it.

> ⚠️ This creates real resources in your Temporal Cloud account (a namespace and an API key), which may incur cost.

## What you need

- A GitHub account. A free account works: Codespaces includes free monthly usage.
- A Temporal Cloud account. [Sign up here](https://temporal.io/get-cloud) if you don't have one.

## Run it with Copilot CLI

The setup runs in **Copilot CLI**, GitHub Copilot in your terminal. It's preinstalled and signs in with your GitHub account.

1. Click **Open in GitHub Codespaces** above, then **Create codespace**. The first start takes a few minutes.
2. Open a terminal: **Terminal → New Terminal**.
3. Start Copilot CLI:

   ```bash
   copilot
   ```

   The first time, Copilot asks you to trust this folder (choose yes) and may ask you to sign in: type `/login` and follow the prompts. If you don't have Copilot yet, Copilot Free is included with your GitHub account.
4. Start the setup by typing the skill's slash command:

   ```text
   /temporal-cloud-setup
   ```

   Then answer the questions as they come up. To check the skill is available, type `/skills list`.

Copilot Free includes a monthly usage allowance.

## Already use Claude Code, Cursor, or Codex?

Run the skill on your own computer instead: install the Temporal plugin for your agent.

- **Claude Code:** [temporalio/claude-temporal-plugin](https://github.com/temporalio/claude-temporal-plugin)
- **Cursor:** [temporalio/cursor-temporal-plugin](https://github.com/temporalio/cursor-temporal-plugin)
- **Codex:** [temporalio/codex-temporal-plugin](https://github.com/temporalio/codex-temporal-plugin)

## Signing in from a browser tab

If you're using Codespaces in a browser tab, the page you land on after signing in to Temporal Cloud may fail to load. That's expected. Copy that page's full address, open a new terminal in the Codespace, and run:

```bash
finish-login '<paste the address here>'
```

The sign-in then finishes on its own. Using the VS Code desktop app instead? You won't need this step.

## When you're done

- **Delete the Codespace** from [github.com/codespaces](https://github.com/codespaces). Your API key is saved inside it.
- **Delete the namespace** if you don't plan to keep it: ask your agent "how do I clean up?"

Codespaces stops itself after 30 minutes idle, so a forgotten one won't use up your free hours.
