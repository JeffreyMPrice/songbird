# Welcome to SongBird

## What is Songbird?

SongBird is a framework that generates end point activity across Windows, macOS and Linux. This allows an Endpoint Detection and Response (EDR) agent to be tested and to ensure that the EDR is generating appropriate telemetry. 

## Assumptions

1. We are assuming good intentions with SongBird. 
   * No one will abuse the process activity to run something they shouldn't. Executing arbitrary executables is generally frowned upon.
   * No one will abuse the network activity to attempt to do harm to another website.
   * No one will abuse the file activity to attack the host computer and delete or modify necessary system files or
create files with malicious content.
2. SongBird does not care about STDOUT or STDERR from any activity it executes.
3. SongBird logs time in UTC.
4. When using process activities, SongBird is not responsible for monitoring network
or file activity generated by the new process.
5. When using process activities, SongBird is sent a process that works across all supported platforms.
6. When using network activities, SongBird does not monitor the low level connection and
is only concerned about the data sent over the connection once established.


## Usage

`rake clean` to remove any artifacts from older runs. Cleans up the work directory.

`rake build` to build the work directory for a new telemetry run. Runs clean before copying data.

`rake run` will load the activities in 'activities.json' and start SongBird. Will run a clean
and build before starting.

## Configuration

SongBird takes an 'activities.json' file in the root project folder and reads in the actions
listed inside. It will run each action in the order in which they appear.

Three actions are currently supported:
1. **File** actions
1. **Network** actions
1. **Process** actions


For file actions, you must provide the operation to perform and the filename. 
```
{"file": {
          "operation": "create|modify|delete",
          "filename": "<filename>"
         }
}
```

For network actions, you must provide an address and port.
```
{"network": {
             "address": "<url>",
             "port": "<port>"
}}
```

For the process action, you must provide an executable and arguments.
```
{"process": {
            "executable": "ping",
            "arguments": ["www.google.com"]
            }
}
```

Please see this project's [activities.json](activities.json) for a complete example.

## Development

Rake is used to manage development tasks.

`rake rubocop` to enforce code style and best practices. Rubocop is set to autocorrect for your convenience.

`rake spec` to run the test suite.

## Extending the framework

SongBird is meant to be easily extended to generate new activities. Create a new subclass of Activity and implement the 'answers?', 'log', 'intitialize' and 'execute' methods. The framework will automatically register your new class and execute any events that use the new class "answers?".

## Testing Environments

* Linux
  * Ubuntu 20.04.1 LTS (Focal Fossa)
  * Ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]
* Windows
  * Windows 10 Version 21H1 (OS Build 19043.1766)
  * Ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x64-mingw-ucrt]

## Known Issues
* NetworkActivity - When run on linux (and possibly macOS), ping does not terminate after 4 pings. There is a kill_all that
runs as the last step to deal with this issue.

## Future Enhancements
* Pass in an argument to specify the configuration file
* Test on macOS
* Enable process activities to run only on specific platforms
* Enhanced NetworkActivity class 
  * Send other data than a GET get request
  * Use different protocols other than HTTP
* Expanded documentation in code 
* Expanded test coverage. I favored functionality over tests given the time requirements.
* Enhanced project hygiene. Near time limit I expanded the scope of my issues and did more than one feature per issue.
* More comprehensive error handling
* Logging enhancements:
  * Allow log file per activity type
  * Allow user specified logging location
  * Allow logging to different formats (XML, CSV, etc)

## Why use the name SongBird?

Historically, miners brought canaries into mine tunnels. If dangerous gases, such as carbon monoxide, collected in the mine, then the gases would kill the canary, which warned the miners to exit the tunnels immediately. The SongBird framework is dedicated to those birds who provided safety and security for miners.