#/bin/sh

# >>> modify bars
sed -i '/amdgpu_bl0/s/^c/;&/' ./bars.ini
sed -i '/intel_backlight/s/;//' ./bars.ini
sed -i '/battery =/cbattery = BAT0' ./bars.ini
sed -i '/adapter =/cadapter = ADP1' ./bars.ini
# <<< modify bars

# >>> modify modules
sed -i '/battery =/cbattery = BAT0' ./modules.ini
sed -i '/adapter =/cadapter = ADP1' ./modules.ini
wireless_name="wlp3s0"
usb_wireless_name="wlp0s20f0u2u4i2"
sed -i '/\[module\/network\]/,+2s/interface.*/interface = enp2s0/' ./modules.ini
network=$(sed -n -e '/\[module\/network\]/=' modules.ini)
network=`expr $network + 3`
wireless_network=$(sed -n -e '/\[module\/wireless-network\]/=' modules.ini)
usb_wireless_network=$(sed -n -e '/\[module\/usb-wireless-network\]/=' modules.ini)

# modify wireless-network
if [ $wireless_network ];then
    sed -i "/\[module\/wireless-network\]/,+2s/interface.*/interface = ${wireless_name}/" ./modules.ini
else
    sed -i "${network}a\[module\/wireless-network\]\ntype = internal\/network\ninterface = ${wireless_name}\n" ./modules.ini
fi

# modify usb-wireless-network
if [ $usb_wireless_network ]; then
    sed -i "/\[module\/usb-wireless-network\]/,+2s/interface.*/interface = ${usb_wireless_name}/" ./modules.ini
else
    sed -i "${network}a\[module\/usb-wireless-network\]\ntype = internal\/network\ninterface = ${usb_wireless_name}\n" ./modules.ini
fi
# <<< modify modules

# >>> modify config
sed -i "s/ network / wireless-network /" ./config.ini
# <<< modify config
