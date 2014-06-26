#!/usr/bin/env bash
SHELL_PWD_PATH="$(cd $(dirname $0);pwd -P)"
HA_DIR="${SHELL_PWD_PATH}"
HA_RUN="$HA_DIR/run"
HA_CONF="$HA_DIR/etc"
HA_SBIN="$HA_DIR/sbin"
HA_PLUGIN="$HA_DIR/plugin"
HA_MESSAGE="$HA_SBIN/message_agent"
HA_LOG="$HA_DIR/log"
HA_TEMP="$HA_DIR/template"
HA_TMP="$HA_DIR/tmp"
HA_INIT="$HA_DIR/init"


[ -f ${HA_LOG} ] || mkdir ${HA_LOG}
[ -f ${HA_TEMP} ] || mkdir ${HA_TEMP}
[ -f ${HA_TMP} ] || mkdir ${HA_TMP}
[ -f ${HA_RUN} ] || mkdir ${HA_RUN}
sh -x $HA_INIT/install_run
