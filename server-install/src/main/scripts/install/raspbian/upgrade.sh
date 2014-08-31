#!/bin/sh
#
#Assumes root, make sure to call as 'sudo ./install.sh'
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Call as 'sudo ./upgrade.sh'" 1>&2
   exit 1
fi

#
SRCPATH=$(dirname $(readlink -f $0))
SRCROOT=$SRCPATH/../..
INSTALLATION_ROOT=/opt/nethome
CONFIGURATION_ROOT=/etc/opt/nethome
LOG_ROOT=/var/log/nethome
PID_ROOT=/var/run/nethome
PID_FILE=$PID_ROOT/nethome.pid
NH_GROUP=nethome
NH_USER=nethome

# Check so there really is an existing installation
if [ ! -x /etc/init.d/nethome -o ! -d "$INSTALLATION_ROOT" -o ! -d "$CONFIGURATION_ROOT" -o ! -d /home/nethome]; then
  echo "Cannot find a complete installation to upgrade. The server must be installed with the installation script found in the same folder as this script."
  exit 1
fi

# Install a new lib directory
chmod +w $INSTALLATION_ROOT/lib_backup
rm -r $INSTALLATION_ROOT/lib_backup
mv $INSTALLATION_ROOT/lib $INSTALLATION_ROOT/lib_backup
cp -r $SRCROOT/lib $INSTALLATION_ROOT/lib
chmod -w $INSTALLATION_ROOT/lib

