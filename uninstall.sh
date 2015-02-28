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

[ "$1" != "YeS" ] && exit 0


crm resource stop eyou_mount_disk
wait
crm resource stop eyou_mail_vip
wait
crm resource stop eyou_check_clone
wait
crm resource stop pingdclone
wait
crm configure erase
wait
for i in $(find /etc/init.d/ -type l|grep -E 'eyou_mount|gw|eyou_mail_|eyou_cron')
	do
	unlink $i
	echo $i 解除链接成功
	wait
done

/etc/init.d/pacemaker stop
/etc/init.d/corosync stop
chkconfig pacemaker off
chkconfig corosync off
