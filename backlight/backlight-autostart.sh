#!/bin/bash
if [ -f /etc/systemd/system/rc-local.service ];
then
    echo 'Error: find /etc/systemd/system/rc-local.service'
    echo 'please append sentences below by yourselves:

[Install]
WantedBy=multi-user.target
Alias=rc-local.service

'
else
    sudo ln -fs /lib/systemd/system/rc-local.service /etc/systemd/system/rc-local.service
    echo '[Install]
WantedBy=multi-user.target
Alias=rc-local.service' >> /etc/systemd/system/rc-local.service
fi

#创建/etc/rc.local文件
if [ -f /etc/rc.local ];
then
    echo 'Error: find /etc/rc.local'
    echo 'please append sentences below by yourselves:

#!/bin/bash
/bin/backlight_load.sh
exit 0

'
else
    sudo touch /etc/rc.local
    #编辑/etc/rc.local文件
    echo '#!/bin/bash
/bin/backlight_load.sh
exit 0' > /etc/rc.local
fi
