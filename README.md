Cloud9 3.0 SDK for Plugin Development (and running standalone) with Docker
==========================================================================


This is a Dockerfile that will download and build the Cloud9 3.0 SDK on Debian Jessie
The core repo for it is https://github.com/c9/core to learn more about what it is.


#### Building ####
To start it, you would build the docker image:
`docker build -t c9sdk .`

#### Running ####
Then run it:
`docker run -it -v ~/code:/workspace c9sdk -w /workspace -p 8181 -a : -l 0.0.0.0`

which would start an instance, using ~/code as your workspace on 8181.  The defaults
are also pretty sane if you are running it locally behind a firewall.  Be sure to pay attention to 
the security warning about no authentication and listening on a world readable port.

To see all the options, run:
`docker run -it -v ~/code:/workspace c9sdk --help` and you will get something like:
```bash
Starting standalone
Usage: ../.c9/node/bin/node ./server standalone

Options:
  --settings          Settings file to use                                                    [default: "devel"]
  --dump              dump config file as JSON
  --domains           Primary and any secondary top-level domains to use (e.g, c9.io,c9.dev)  [default: null]
  --exclude           Exclude specified service
  --include           Include only specified service
  --helpWithSudo      Ask for sudo password on startup
  --help              Show command line options.
  -t                  Start in test mode
  -k                  Kill tmux server in test mode
  -b                  Start the bridge server - to receive commands from the cli              [default: false]
  -w                  Workspace directory                                                     [default: "/home/cloud9/c9sdk"]
  --port              Port                                                                    [default: 8181]
  --debug             Turn debugging on                                                       [default: false]
  --listen            IP address of the server                                                [default: "127.0.0.1"]
  --workspacetype     The workspace type to use
  --readonly          Run in read only mode
  --packed            Whether to use the packed version.                                      [default: false]
  --hosted            Use default config of the hosted version                                [default: false]
  --auth              Basic Auth username:password
  --collab            Whether to enable collab.                                               [default: false]
  --cache             use cached version of cdn files                                         [default: true]
  --setting-path      The path to store the settings.
  --inProcessLocalFs  Whether to run localfs in same process for debugging.
```
