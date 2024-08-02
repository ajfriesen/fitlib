#!/usr/bin/env just --justfile

MAIN_PACKAGE_PATH := "./cmd"
BINARY_NAME := "fitlib"

# default recipe to display help information
default:
  @just --list

build:
	# Include additional build steps, like TypeScript, SCSS or Tailwind compilation here...
	go build -o=/tmp/bin/{{BINARY_NAME}} {{MAIN_PACKAGE_PATH}}

# Run sqlc
sqlc:
  sqlc generate

# run application
run: sqlc
    go run github.com/air-verse/air@latest \
    --build.cmd "just build" --build.bin "/tmp/bin/{{BINARY_NAME}}" --build.delay "100" \
    --build.exclude_dir "" \
    --build.include_ext "go, tpl, tmpl, html, css, scss, js, ts, sql, jpeg, jpg, gif, png, bmp, svg, webp, ico" \
    --misc.clean_on_exit "true"

# delete SQLite content
db-delete:
  rm -rf ./data/database/*

# Run goose migration up
db-up:
  goose --dir migrations sqlite "data/database/fitlib.db" up

# run goose migration down
db-down:
  goose --dir migrations sqlite "data/database/fitlib.db" down