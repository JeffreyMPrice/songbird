# Welcome to SongBird

## What is Songbird?

SongBird is a framework that generates end point activity across Windows, macOS and Linux. This allows an Endpoint Detection and Response (EDR) agent to be tested and ensure that the EDR is generating appropriate telemety. 

## Assumptions

1. We are assuming good intentions with SongBird. 
   * No one will abuse the process activity to run something they shouldn't. Executing arbitrary executables is generally frowned upon.
   * No one will abuse the network activity to attempt to do harm to another website.
   * No one will abuse the file activity to attack the host computer and delete or modify necessary system files or
create files with malicious content.
2. SongBird does not care about STDOUT or STDERR from any activity it executes
3. SongBird logs in UTC
4. When using process activities, SongBird is not responsible for monitoring process network
or file actions.
5. When using process activities, SongBird is sent a process that works across all supported platforms.
6. When using network activities, SongBird is not monitoring the low level connection protocol and
is only concerned about the data sent over the connection once established.


## Usage

`rake clean` to remove any artifacts from older runs. Cleans up the work directory.

`rake build` to build the work directory is ready for a new telemetry run. Runs clean before copying data. Will run clean
before executing

`rake run` will load the activities in 'activities.json' and start SongBird. Will run a clean
and build before starting.

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
             "address": "<url>",
             "port": "<port>",
             "data": "<your data>"
}}
```

For the process action, you must provide an executable if you wish
that process to run in each environment.
```
{"process": {
            "executable": "ping",
            "arguments": ["www.google.com"]
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

## Testing Environments

* Linux
  * Ubuntu 20.04.1 LTS (Focal Fossa)
  * Ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]
* Windows
  * Windows 10 Version 21H1 (OS Build 19043.1766)
  * Ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x64-mingw-ucrt]

## Known Issues
* NetworkActivity - On linux ping does not terminate after 4. Windows and linux use different
  command line arguments for the ping count.

## To Do
* Consider the ability to pass in an argument to specify the configuration file
* macOS testing
* Enable process activities across or only on specific platforms.
* Better NetworkActivity. 
  * send other data than baked in
  * use different protocols
* Better in code documentation 
* Better tests. I favored functionality over tests in the end
* Better project hygiene. Near the end I got a bit loose with commits and issues,
favoring just getting things done.
* Better error handling
* The execute method on each Activity really looks like it could call a block and yield.
* Configurable logger and general logging improvements

## Why use the name SongBird?

Since the early 1900s, miners would carry canaries down into the mine tunnels with them. If dangerous gases such as carbon monoxide collected in the mine, the gases would kill the canary before killing the miners, thus providing a warning to exit the tunnels immediately. The SongBird framework is dedicated to those birds that provided safety and security for miners.
