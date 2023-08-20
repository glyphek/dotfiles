# Firejail profile for vis
# Description: Vi IMproved - enhanced vi editor
# This file is overwritten after every install/update
# Persistent local customizations
include vis.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.vis
noblacklist ${HOME}/.visinfo
noblacklist ${HOME}/.visrc

# Allows files commonly used by IDEs
include allow-common-devel.inc

include disable-common.inc
include disable-programs.inc

include whitelist-runuser-common.inc

caps.drop all
netfilter
nodvd
nogroups
noinput
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp

private-dev
