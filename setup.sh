#!/usr/bin/env bash

#****************************************************************************
# Filename      : setup.sh
# Created       : Fri Dec 29 2023
# Author        : Zolo
# Github        : https://github.com/zolodev
# Description   : Replace NIXOS configuration with my personal confs.
#****************************************************************************


# Constants
EXT=".nix"
CONF_NAME="configuration"
CONF_FILENAME=$CONF_NAME$EXT
HW_CONF_NAME="hardware-"$CONF_NAME
HW_CONF_FILENAME=$HW_CONF_NAME$EXT


#****************************************************************************


# Set environmental variables, prefixed and namspaced with Z

# Get the nixos-config path from $NIX_PATH
export ZNIXOS_CONFIG_PATH=$(echo $NIX_PATH | grep -o 'nixos-config.*'$CONF_FILENAME | grep -o "/.*"$EXT)

# Creating a path for hardware configuration
export ZNIXOS_HW_CONFIG_PATH=${ZNIXOS_CONFIG_PATH/$CONF_NAME/$HW_CONF_NAME}
echo $ZNIXOS_HW_CONFIG_PATH



#****************************************************************************
#
# Replace - Hardware Configuration file
#
#****************************************************************************

# Backup configuration file 
if [ ! -f ${ZNIXOS_HW_CONFIG_PATH}_ -a -f $ZNIXOS_HW_CONFIG_PATH  ]; then
  echo "Backing up Hardware Configuration file"
    yes | sudo mv $ZNIXOS_HW_CONFIG_PATH ${ZNIXOS_HW_CONFIG_PATH}_
fi

# Unlink the path if it exists
if [ -f ${ZNIXOS_HW_CONFIG_PATH} ]; then
  sudo unlink $ZNIXOS_HW_CONFIG_PATH
fi

# Add a linked configuration file
sudo ln -s $PWD/$HW_CONF_FILENAME $ZNIXOS_HW_CONFIG_PATH


#****************************************************************************
#
# Replace - Configuration file
#
#****************************************************************************

# Backup configuration file 
if [ ! -f ${ZNIXOS_CONFIG_PATH}_ -a -f $ZNIXOS_CONFIG_PATH  ]; then
  echo "Backing up configuration file"
    yes | sudo mv $ZNIXOS_CONFIG_PATH ${ZNIXOS_CONFIG_PATH}_
fi

# Unlink the path if it exists
if [ -f ${ZNIXOS_CONFIG_PATH} ]; then
  sudo unlink $ZNIXOS_CONFIG_PATH
fi

# Add a linked configuration file
sudo ln -s $PWD/$CONF_FILENAME $ZNIXOS_CONFIG_PATH

