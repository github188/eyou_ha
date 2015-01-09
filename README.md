<div>#!</div><div><<br>
</div><div><<br>
</div><div>modfiy 2014 12 30</div><div>by: liguopeng@eyou.net &nbsp;mailbad@163.com</div><div><<br>
</div><div>更新版本 &nbsp;仅限 update version corosync 1.4.7 pacemaker 1.1.12 crmsh 2.1</div><<br>
<div>架构图</div><<br>
![Image text](https://github.com/mailbad/eyou_ha/blob/master/init/ha.png)
<div>小BUG修复。</div><div>update gateway only install.</div><div>==========================</div><div><<br>
</div><div><<br>
</div><div><<br>
</div><div>modfiy 2014 05 09</div><div>by: liguopeng@eyou.net</div><div><<br>
</div><div>redhat centos 5.x 6.x eyou_mail heartbeat 负载</div><div>全面支持 V5-V8 eyou 邮件服务。</div><div>请在配置前进行系统优化，以及sudoer 文件的权限配置。</div><div><<br>
</div><div><<br>
</div><div>pacemkaer 高级监控功能</div><div>corosync 心跳模式</div><div><<br>
</div><div>默认日志存放 ./log/ha.日期.log</div><div><<br>
</div><div><<br>
</div><div>./init &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;初始化目录。\r</div><div>./plugin &nbsp; &nbsp; &nbsp; &nbsp;会链接到/etc/init.d/ 下 ，使pacemaker 可以调用。</div><div>./sbin &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;plugin下程序会进行调用。</div><div>./tmp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 临时目录。</div><div>./template &nbsp; &nbsp; &nbsp;存放一些模板类，如初始化生成的eyou_mail_pid HA_WATCH.ini 不变的文件。</div><div>./etc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 配置文件目录。</div><div>./log &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; HA 相关进程 的日志目录。</div><div>./run &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; HA 下程序启动产生的PID存放。</div><div><<br>
</div><div><<br>
</div><div>实现的功能：</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 1. &nbsp; &nbsp; &nbsp;全面支持 eyou_mail 服务的详细监控 &nbsp; 默认开启（当服务出现故障，会自动拉起服务，如果程序出现故障10次 将切换）</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 2. &nbsp; &nbsp; &nbsp;支持邮件网关2合一 的HA 部署， 网关程序不会进行监控。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 3. &nbsp; &nbsp; &nbsp;支持多存储，多类型存储。支持UUID 方式挂载 &nbsp;使用-U 参数 &nbsp;心跳盘也可使用UUID 方式。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 4. &nbsp; &nbsp; &nbsp;当nfs设备掉线 会自动释放资源，这块程序需要一系列判断 会慢些 &nbsp;但控制在1分钟之内。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 5. &nbsp; &nbsp; &nbsp;当网络出现故障， 自动释放磁盘。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 6. &nbsp; &nbsp; &nbsp;心跳线故障后，会启用磁盘心跳机制，避免HA 闹裂导致存储数据损坏。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 7. &nbsp; &nbsp; &nbsp;当任何服务故障处理 或切换过程 均可通过邮件等方式进行通知。 现仅支持邮件方式通知，监控平台接口还未使用，若使用其他方式通知 &nbsp;修改 message_agen</div><div>t 程序即可。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 8. &nbsp; &nbsp; &nbsp;添加eyou程序升级后 HA 不影响处理,但如果eyou程序产生变动 或 之前配置过HA 不监控的程序 需要重新配置 ./template/HA_WATCH.ini 文件。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 9. &nbsp; &nbsp; &nbsp;添加eyou 服务 是否启用监控， 部署完成之后 HA 启动 会自动生成 &nbsp;./template/HA_WATCH.ini 配置文件。</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 运维处理 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;临时关闭服务的监控 修改 ./template/HA_WATCH.ini 即时生效。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 网络故障 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;切换</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 存储故障 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;切换</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 服务故障 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;拉起 失败 切换</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 心跳故障 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;存储正常情况下 不切换。</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 当服务出现故障，关联性服务 会自动重启 &nbsp; 如 mysql 程序故障 &nbsp;拉起mysql的过程会停止 mysql 的关联程序 如 memcache phpd mlist smtp pop local bounce 等服</div><div>务。</div><div><<br>
</div><div><<br>
</div><div>配置HA 前提须知，以下状况不稳定会导致HA 切换。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 1. &nbsp; &nbsp; &nbsp;确保网络稳定。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 2. &nbsp; &nbsp; &nbsp;确保存储线路稳定。</div><div><<br>
</div><div>注意～～！！！！！！！！！！！！！！</div><div>关于修改HA 资源的说明：</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 在使用中 修改任意HA资源 需要停止所有HA资源才可进行更改，不停止服务直接修改资源值的 &nbsp;出问题自己解决。</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 停止HA资源的命令</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource stop eyou_mount_disk</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource stop eyou_check_clone</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource stop pingdclone</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 查看资源是否停止完成</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource status|grep -i start</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 返回空 则代表停止完成，否则还未停止完成。</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 修改完资源后，启动资源</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource start pingdclone</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource start eyou_check_clone</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; crm resource start eyou_mount_disk</div><div>&nbsp; &nbsp; &nbsp; &nbsp; wait;</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 严重注意～～～！！！！！</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 当修改etc/ha_conf.ini 中的配置后 &nbsp;请同步到另一台机器。</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; etc/ha_conf.ini 配置中显示以下的项目需要更改 请往下看。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #仅第一次初始化生效，之后使用中请忽略</div><div><<br>
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 需要修改HA配置的项,在任意一台机器上执行即可。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 1. &nbsp; &nbsp; &nbsp;修改虚拟IP 请使用 [ crm configure edit eyou_mail_vip ] 修改相应资源 保存即可。</div><div>&nbsp; &nbsp; &nbsp; &nbsp; 2. &nbsp; &nbsp; &nbsp;修改网络通信地址 请使用 [ crm configure edit pingd ] 修改相应资源 保存即可。</div>
