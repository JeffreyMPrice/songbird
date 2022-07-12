# Welcome to SongBird

## What is Songbird?

SongBird is a framework that generates end point activity across Windows, macOS and Linux. This allows an Endpoint Detection and Response (EDR) agent to be tested and ensure that the EDR is generating appropriate telemety. 

## Usage

`rake clean` to remove any artifacts from older runs. Cleans up the work directory.

`rake build` to build the work directory is ready for a new telemetry run. Runs clean before copying data. Will run clean
before executing

`rake run` will load the activities in 'activities.json' and start SongBird

## Configuration

SongBird takes an 'activities.json' file in the root project folder and reads in the actions
listed inside. It will run each action in the order in which they appear.

For file actions, you must provide the operation to perform and the filename. 
```
{"file": {
          "operation": "create|modify|delete",
          "filename": "<filename>"
         }
}
```

For network actions, you must provide a location and data to transmit.
```
{"network": {
             "location": "<URL>",
             "data": "<your data>"
}}
```

For the process action, you must provide an executable if you wish
that process to run in each environment.
```
{"process": {
            "executable": { "win": "dir",
                            "linux":  "ls",
                             "macOS":  "ls"}
                           }
}
```

Please see this project's [activities.json](activities.json) for a complete example.

## Supported Actions

Three actions are currently supported:
1. **File** actions
1. **Network** actions
1. **Process** actions

## Development

Rake is used to manage development tasks.

`rake rubocop` to enforce code style and best practices. Rubocop is set to autocorrect for your convenience.

`rake spec` to run the test suite 

## Extending the framework

SongBird is meant to be easily extended to generate new activities. Create a new class that will subclass off of Activity and implement the 'log', 'intitialize' and 'execute' methods and the framework will automatically register your new class and execute any events that use the new class name.

## To Do
* Consider the ability to pass in an argument to specify the configuration file

## Why use the name SongBird?

Since the early 1900s, miners would carry canaries down into the mine tunnels with them. If dangerous gases such as carbon monoxide collected in the mine, the gases would kill the canary before killing the miners, thus providing a warning to exit the tunnels immediately. The SongBird framework is dedicated to those birds that provided safety and security for miners.
