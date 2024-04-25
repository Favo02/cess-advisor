# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- add university edition branding
- round average rating (issue #15)
- dynamically fetch know issues
- add university field to toilets
- notification after redirect
- redirect to requested page after login/registration
- make theme persistent (save in local storage)
- various small UI/UX improvements
- fetch and show toilet data on new review page
- use `svelte-star-rating` component instead of hardcoded icons for rating display
- add `svelte-star-rating` component instead of number input for rating, clean, temperature input

## Changelog init (Version 1.0)

### Added

- Backend REST API with OCaml, Sihl, Opium, Caqti, Yojson, Validate
- Frontend with Sveltekit, Tailwind CSS, DaisyUI
- PostgreSQL database
- Deployment with Docker, GitHub Actions, Cloudflare Pages
- Changed license to GPLv3 (was CC-BY 4.0 before version 1.0)
