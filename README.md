#!


modfiy 2014 12 30
by: liguopeng@eyou.net  mailbad@163.com

更新版本  仅限 update version corosync 1.4.7 pacemaker 1.1.12 crmsh 2.1
小BUG修复。
update gateway only install.
==========================



modfiy 2014 05 09
by: liguopeng@eyou.net

redhat centos 5.x 6.x eyou_mail heartbeat 负载
全面支持 V5-V8 eyou 邮件服务。
请在配置前进行系统优化，以及sudoer 文件的权限配置。


pacemkaer 高级监控功能
corosync 心跳模式

默认日志存放 ./log/ha.日期.log


./init		初始化目录。\r
./plugin	会链接到/etc/init.d/ 下 ，使pacemaker 可以调用。
./sbin		plugin下程序会进行调用。
./tmp		临时目录。
./template	存放一些模板类，如初始化生成的eyou_mail_pid HA_WATCH.ini 不变的文件。
./etc		配置文件目录。
./log		HA 相关进程 的日志目录。
./run		HA 下程序启动产生的PID存放。


实现的功能：
	1.	全面支持 eyou_mail 服务的详细监控   默认开启（当服务出现故障，会自动拉起服务，如果程序出现故障10次 将切换）
	2.	支持邮件网关2合一 的HA 部署， 网关程序不会进行监控。
	3.	支持多存储，多类型存储。支持UUID 方式挂载  使用-U 参数  心跳盘也可使用UUID 方式。
	4.	当nfs设备掉线 会自动释放资源，这块程序需要一系列判断 会慢些  但控制在1分钟之内。
	5.	当网络出现故障， 自动释放磁盘。
	6.	心跳线故障后，会启用磁盘心跳机制，避免HA 闹裂导致存储数据损坏。
	7.	当任何服务故障处理 或切换过程 均可通过邮件等方式进行通知。 现仅支持邮件方式通知，监控平台接口还未使用，若使用其他方式通知  修改 message_agent 程序即可。
	8.	添加eyou程序升级后 HA 不影响处理,但如果eyou程序产生变动 或 之前配置过HA 不监控的程序 需要重新配置 ./template/HA_WATCH.ini 文件。
	9.	添加eyou 服务 是否启用监控， 部署完成之后 HA 启动 会自动生成  ./template/HA_WATCH.ini 配置文件。

		运维处理		临时关闭服务的监控 修改 ./template/HA_WATCH.ini 即时生效。
		网络故障		切换
		存储故障		切换
		服务故障		拉起 失败 切换
		心跳故障		存储正常情况下 不切换。
		
	当服务出现故障，关联性服务 会自动重启   如 mysql 程序故障  拉起mysql的过程会停止 mysql 的关联程序 如 memcache phpd mlist smtp pop local bounce 等服务。


配置HA 前提须知，以下状况不稳定会导致HA 切换。
	1.	确保网络稳定。
	2.	确保存储线路稳定。

注意～～！！！！！！！！！！！！！！
关于修改HA 资源的说明：
	在使用中 修改任意HA资源 需要停止所有HA资源才可进行更改，不停止服务直接修改资源值的  出问题自己解决。

	停止HA资源的命令
	crm resource stop eyou_mount_disk
	wait;
	crm resource stop eyou_check_clone
	wait;
	crm resource stop pingdclone
	wait;

	查看资源是否停止完成
	crm resource status|grep -i start
	返回空 则代表停止完成，否则还未停止完成。

	修改完资源后，启动资源
	crm resource start pingdclone
	wait;
	crm resource start eyou_check_clone
	wait;
	crm resource start eyou_mount_disk
	wait;

	严重注意～～～！！！！！
	当修改etc/ha_conf.ini 中的配置后  请同步到另一台机器。

	etc/ha_conf.ini 配置中显示以下的项目需要更改 请往下看。
		#仅第一次初始化生效，之后使用中请忽略

	需要修改HA配置的项,在任意一台机器上执行即可。
	1.	修改虚拟IP 请使用 [ crm configure edit eyou_mail_vip ] 修改相应资源 保存即可。
	2.	修改网络通信地址 请使用 [ crm configure edit pingd ] 修改相应资源 保存即可。
