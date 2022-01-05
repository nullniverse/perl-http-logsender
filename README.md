# perl-http-logsender
A perl script to send real-time log file updates via HTTP POST

### Purpose
While there are a ton of software for log sending (agents) across a vast plethora of ecosystems (FluentD, NxLog, etc.), I devised this ingenious solution to open read a file and watch for new writing lines and then grab the newly generated ones, process it for matching patterns (if you want) and then POST to a destination endpoint of your choice - in my case, a custom node-red service. Way faster than config/install a new agent and CPU-use friendly (if you want to scale for dozens, hundreds of log files).

### Use
Use it whenever and the way you want, if possible you could cite this humble maintainers Github account ```@nullniverse```or the repo itself.
