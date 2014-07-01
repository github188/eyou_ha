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


[ -d ${HA_LOG} ] || mkdir ${HA_LOG}
[ -d ${HA_TEMP} ] || mkdir ${HA_TEMP}
[ -d ${HA_TMP} ] || mkdir ${HA_TMP}
[ -d ${HA_RUN} ] || mkdir ${HA_RUN}

[ "$1" == "init" ] && {
sh -x $HA_INIT/init_system_rpm
[ "${?}" -eq "0" ] || exit ${?}
sh -x $HA_INIT/init_create_eyou_shell
[ "${?}" -eq "0" ] || exit ${?}

}

[ -z "${1}" ] && {
sh -x $HA_INIT/install_run
}
	


