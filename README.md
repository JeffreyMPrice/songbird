# Welcome to SongBird

## What is Songbird?

SongBird is a framework that generates end point activity across Windows, macOS and Linux. This allows an Endpoint Detection and Response (EDR) agent to be tested and ensure that the EDR is generating appropriate telemety. 

## Usage

`rake build` to build the work directory is ready for a new telemetry run. Runs clean before copying data.

`rake clean` to remove any artifacts from older runs. Cleans up the work directory.
## Supported Actions

Three actions are currently supported:
1. **Process** actions
1. **File** actions
1. **Network** actions

## Development

Rake is used to manage development tasks.

`rake rubocop` to enforce code style and best practices. Rubocop is set to autocorrect for your convenience.

`rake spec` to run the test suite 

## Extending the framework

SongBird is meant to be easily extended to generate new activities. Create a new class that will subclass off of Activity and implement the 'log', 'intitialize' and 'execute' methods and the framework will automatically register your new class and execute any events that use the new class name.

## Why use the name SongBird?

Since the early 1900s, miners would carry canaries down into the mine tunnels with them. If dangerous gases such as carbon monoxide collected in the mine, the gases would kill the canary before killing the miners, thus providing a warning to exit the tunnels immediately. The SongBird framework is dedicated to those birds that provided safety and security for miners.
