set dotenv-load

@_list:
    just --list --unsorted

install:
    npm install
    npm ci

# Perform all verifications (compile, test, lint, etc.)
verify: lint test

build:
    just run-m run build

test:
    just backend verify

run: install
    npm run tauri dev

lint:
    npm run lint


fmt: fmt-b
    npm run format

fmt-b:
    just backend fmt

backend *args:
    cd src-tauri && just {{args}}


install-dev:
  cargo install cargo-hack cargo-watch cargo-deny hurl cargo-machete
  cargo install cargo-features-manager



release *args: verify
    test $GITHUB_TOKEN
    test $CARGO_REGISTRY_TOKEN
    cd src-tauri && cargo release {{args}}


prune:
    cargo machete
    cargo features prune

update-all:
    npm install -g npm-check-updates
    ncu -u
