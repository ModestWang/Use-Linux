#!/bin/sh
#首先新建了/etc/backlight文件，用于储存亮度数值：
if [ -f /etc/backlight ];
then
    echo 'Warning: Find /etc/backlight'
else
    sudo touch /etc/backlight
    echo 'Created /etc/backlight'
fi
sudo chmod 777 /etc/backlight


#先在/usr/bin新建一个脚本backlight_save.sh
if [ -f /usr/bin/backlight_save.sh ];
then
    echo 'Warning: Find /usr/bin/backlight_save.sh'
else
    sudo touch /usr/bin/backlight_save.sh
    echo 'Created /usr/bin/backlight_save.sh'
fi
sudo chmod 777 /usr/bin/backlight_save.sh
echo '#!/bin/sh
cat /sys/class/backlight/intel_backlight/brightness > /etc/backlight ' > /usr/bin/backlight_save.sh


#接着我们写一个关机时自动运行的服务（在/lib/systemd/system新建一个.service文件）：
if [ -f /lib/systemd/system/backlight_shut.service ];
then
    echo 'Warning: Find /usr/bin/backlight_load.sh'
else
    sudo touch /lib/systemd/system/backlight_shut.service
    echo 'Created /lib/systemd/system/backlight_shut.service'
fi
echo '[Unit]
Description=关机时保存屏幕亮度信息
After=display-manager.service
Before=systemd-poweroff.service systemd-reboot.service systemd-halt.service
DefaultDependencies=no

[Service]
ExecStart=/usr/bin/backlight_save.sh
Type=forking

[Install]
WantedBy=poweroff.target
WantedBy=reboot.target
WantedBy=halt.target' > /lib/systemd/system/backlight_shut.service
#接着将此服务软链接到want的三个文件夹中（此操作与上面的服务相关，具体细节请查阅systemd相关文档）
sudo ln -s /lib/systemd/system/backlight_shut.service /lib/systemd/system/poweroff.target.wants
sudo ln -s /lib/systemd/system/backlight_shut.service /lib/systemd/system/reboot.target.wants
sudo ln -s /lib/systemd/system/backlight_shut.service /lib/systemd/system/halt.target.wants

#然后我们直接重启单元块：
sudo systemctl daemon-reload

#再写一个将/etc/backlight中数值加载到/sys/class/backlight/xxxcpu/brightness中的可执行脚本：
if [ -f /usr/bin/backlight_load.sh ];
then
    echo 'Warning: Find /usr/bin/backlight_load.sh'
else
    sudo touch /usr/bin/backlight_load.sh
    echo 'Created /usr/bin/backlight_load.sh'
fi
sudo chmod 777 /usr/bin/backlight_load.sh
echo '#!/bin/sh
    echo "1111" | sudo -S chmod 777 /sys/class/backlight/intel_backlight/brightness
    cat /etc/backlight > /sys/class/backlight/intel_backlight/brightness' > /usr/bin/backlight_load.sh

# 最后需要将 /bin/backlight_load.sh 加入开机自启动
if [ -f backlight-autostart.sh ];
then
    echo 'Find backlight-autostart.sh, setting backlight_load.sh as autostart script.'
    ./backlight-autostart.sh
else
    echo 'Error: Not find backlight-autostart.sh, please move it near the backlight.sh'
    exit
fi

echo 'done'
