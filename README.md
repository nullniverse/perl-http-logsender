# perl-http-logsender
A Perl script to send real-time log file updates via HTTP POST

### Purpose
While there are a ton of software for log sending (agents) across a vast plethora of ecosystems (FluentD, NxLog, etc.), I devised this ingenious solution to open read a file and watch for new writing lines and then grab the newly generated ones, process it for matching patterns (if you want) and then POST to a destination endpoint of your choice - in my case, a custom node-red service. Way faster than config/install a new agent and CPU-use friendly (if you want to scale for dozens, hundreds of log files).

### Use
Use it whenever and the way you want.

### Hints

Look out for ```LWP::Protocol::https``` among your CPAN modules, if you are
planning to POST or GET to an endpoint using TLS (https). 

To install it, issue ``` $sudo cpan install LWP::Protocol::https```.

#### Adjust yum.repos.d if you're in CentOS >= 7

Edit:
```/etc/yum/repos.d/CentOS-Linux-AppStream.repo```

```
1) dnf clean all
2) dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos # ( you may need to run this twice - due to dnf auto-aborting )
3) dnf clean all
4) sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
5) sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
6) yum update -y
7) sudo dnf distro-sync
8) sudo dnf install cpan
9) sudo dnf install tmux
10) sudo dnf install **Perl Modules**
11) sudo cpan install LWP::Protocol::https
```


