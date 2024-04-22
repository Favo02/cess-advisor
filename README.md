<img src="https://github.com/Favo02/cess-advisor/assets/59796435/f71a96e5-5769-46e4-a547-93cff46b1b7b" width="150" align="right" alt="Logo" />

# Cess Advisor

**Cess Advisor** 🐪🚽 is a _stupid_ yet really _useful_ web app that helps you find a _suitable toilet_ when you are in a hurry.

## Tech stack

TL;DR: **OCaml** 🐪 (Sihl) + **JavaScript** 🤢 (SvelteKit) + **PostgreSQL** 🐘

> [!TIP]
> If you want to preserve your mental health, you should **NOT** write JavaScript code _(and frontends in general)_. OCaml is just better.

The project started as an excuse to _play around_ with **OCaml**, but I needed a _frontend_ to make it useful. I tried to pick the _simplest_ one and ended up with **Svelte**. But I absolutely _fucked up_ and started a **SvelteKit** project (the docs don't mention how to setup a _vanilla Svelte_ project). So I ended up writing SSR pages and basically **two backends**.

<details>
<summary>Detailed tech stack</summary>

- Backend: **OCaml** 🐪
  - [Sihl](https://github.com/oxidizing/sihl): OCaml framework for building web apps
  - [Opium](https://github.com/rgrinberg/opium/): OCaml library for managing HTTP requests
  - [Caqti](https://github.com/paurkedal/ocaml-caqti): OCaml library for interacting with databases
  - [Yojson](https://github.com/ocaml-community/yojson): OCaml library for JSON serialization
  - [Validate](https://github.com/Axot017/validate): OCaml library for validating schemas

- Frontend: **JavaScript** 🤢
  - [Sveltekit](https://kit.svelte.dev/): JavaScript framework for web development
  - [Tailwind CSS](https://tailwindcss.com/): CSS framework
  - [DaisyUI](https://daisyui.com/): Tailwind components library

- Database: 🐘
  - [PostgreSQL](https://www.postgresql.org/): relational database

</details>

## Deployment

TL;DR: **Docker** 🐳 + **GitHub Actions** 🤖 for backend and **Cloudflare Pages** ☁️ for frontend

<details>
<summary>Detailed deployment</summary>

- Backend: **Docker** 🐳 + **GitHub Actions** 🤖
  - each time a commit is pushed to the `main` branch, `deploy-backend` GitHub action is triggered
  - the action connects via ssh to the server, pulls the changes and rebuilds the Docker container
  - the backend is available at [https://cessadvisorapi.favo02.dev](https://cessadvisorapi.favo02.dev)
  - instructions:
    - add `HOST`, `USERNAME`, `PORT`, `KEY`, `SCRIPT` secrets to GitHub
    - add private `KEY` provided in secrets to allowed hosts on server
    - clone this repository on the server
    - create `.env` file in the root of the repository (see [.env.template](./.env.template) for reference)
    - create empty folder `logs` in the root of the repository
    - `SCRIPT` secret should cd into the repository and run `git pull` and `docker-compose up -d --build --force-recreate`

- **Frontend**: **Cloudflare Pages** ☁️
  - each time a commit is pushed to the `main` branch, the Cloudflare pages integration detects the change
  - the integration builds the Sveltekit app with some magic
  - the frontend is available at [https://cessadvisor.pages.dev](https://cessadvisor.pages.dev)
  - instructions:
    - create a new Cloudflare Pages project
    - follow instructions to connect the project to the GitHub repository
    - set `Root directory (advanced)` as `frontend`
    - set environment variables (see [frontend/.env.template](frontend/.env.template))

</details>

## Contributing and License

The project is licensed under the **GPLv3** license.

_It was licensed under **CC-BY 4.0** before version 1.0 (commit `a21d9f70c002aa497e5196308c6e71012211e468`), so the code before that commit is licensed under **CC-BY 4.0** (the license is not revokable)._

Each contribution is **welcome**, especially building alteranive better frontends _(if you are brave enough to write JavaScript code)_.

Please follow the [conventions](#conventions) below.

## Conventions

<details>
<summary>Commit convention</summary>

This project follows the following **commit convention**: `<type>(<part>/<scope>): <summary>`

- **Type**: commit type
  - `feat`: add new feature
  - `fix`: bug fix
  - `refactor`: code refactoring
  - `build`: build system _(dependencies, ...)_
  - `test`: add tests
  - `docs`: documentation changes
  - `ci`: continuous integration _(github actions, ...)_

- **Module**/**Scope**: commit part (mandatory) and scope (optional)
  - `be/`: backend
    - `handlers`: request handlers
    - `middlewares`: middleware functions
    - `utils`: utility module
  - `fe/`: frontend
    - `components`: components
    - `pages`: pages (client side)
    - `ssr`: server side rendered pages
    - `services`: interaction with backend API
    - `validators`: form validators
  - `db/`: database
    - `tables`: tables
  - `repo`: repository _(omit scope)_

- **Summary**: commit summary, present tense, start with lowercase, no period at the end

_Adding new scopes is allowed if necessary, just add it to the list above._

</details>

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) file.
