# perl-http-logsender
A perl script to send real-time log file updates via HTTP POST

### Purpose
While there are a ton of software for log sending (agents) across a vast plethora of ecosystems (FluentD, NxLog, etc.), I devised this ingenious solution to open read a file and watch for new writing lines and then grab the newly generated ones, process context for matching patterns (if you want) and then POST to a destination endpoint - in my case, a custom node-red service. 

### Use
Use it whenever and the way you want, if possible you could cite this humble maintainers Github account ```@nullniverse```or the repo itself.
