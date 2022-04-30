#!/bin/bash
#terminal settings dont touch
clear
BLUE="\e[36m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
RED="\e[91m"
YELLOW="\e[93m"
#terminal settings dont touch
 
#settings
startUDP=14700 #enter the starting udp port
realMap=false # true // false 
mapLoaction=0 # 0 = samsun // 1 = eskisehir // 2 = istanbul // 3 = mcmillan # If you select fake world you cannot select mcmillan
mapType=vehicles # empty - vehicle - vehicles - frozen
#vehicle; best option for QR bot // vehicles; best option for Fighter UAV bot // frozen; best option for only image processing with randomGoTo bot
botdiff=1 # 0 = easy // 1 = normal // 2 = hard // 3 = expert #enemy bot difficulty
botType=1 # 0 = disable // 1 = fighterUAV // 2 = QRbot // 3 = randomGoTo 
gazeboGui=true # true // false # her iki durumda da motor daima etkin
clear=enable # enable // disable # çıkışta gereksiz logları silme
#settings

#lokasyona göre konumlar dont touch
samsun_carsamba=("${GREEN}
Fighter UAV Competition coordinates: ${BLUE}
latmin=41.2714445
latmax=41.2745409
longmin=36.5420616
longmax=36.5481234${ENDCOLOR}
${GREEN}
Fighter UAV QR coordinates:${BLUE}
41.27371117 36.54610957   test_ucusu_m
41.27346260 36.54614445   mustafakemalataturk_m
41.27303270 36.54732937   istikbal_goklerdedir_q
41.27344964 36.54494403   teknofest_h${ENDCOLOR}")

hasan_polatkan=("${GREEN}
Fighter UAV Competition coordinates:${BLUE}
latmin=39.8265502
latmax=39.8296400
longmin=30.4944742
longmax=30.5004072${ENDCOLOR}
${GREEN}
Fighter UAV QR coordinates:${BLUE}
39.82853660 30.49775910   test_ucusu_m
39.82830170 30.49775910   mustafakemalataturk_m
39.82786821 30.49895444   istikbal_goklerdedir_q
39.82828815 30.49662495   teknofest_h${ENDCOLOR}")

istanbul_airport=("${GREEN}
Fighter UAV Competition coordinates:${BLUE}
latmin=41.2823619
latmax=41.2855142
longmin=28.7133372
longmax=28.7196565${ENDCOLOR}
${GREEN}
Fighter UAV QR coordinates:${BLUE}
41.28410826 28.71609380  test_ucusu_m
41.28386131 28.71612960  mustafakemalataturk_m
41.28342268 28.71732269  istikbal_goklerdedir_q
41.28384374 28.71493156  teknofest_h${ENDCOLOR}")

mcmillan_airport=("${GREEN}
Fighter UAV Competition coordinates:${BLUE}
latmin=35.7218833
latmax=35.7250364
longmin=-120.7716107
longmax=-120.7774687${ENDCOLOR}
${GREEN}
Fighter UAV QR coordinates:${BLUE}
35.72285994 -120.77583165  test_ucusu_m
35.72385209 -120.77488093  mustafakemalataturk_m
35.72337693 -120.77278143  istikbal_goklerdedir_q
35.72341750 -120.77420400  teknofest_h${ENDCOLOR}")

#lokasyonlar icin iha otopilot ayarları dont touch
if [[ "$mapLoaction" = 0 ]]
then
location=41.25496844,36.56789256
mac=0
map=0
helpMap=$samsun_carsamba
fi
if [[ "$mapLoaction" = 1 ]]
then
location=39.80979394,30.51907959
mac=1
map=1
helpMap=$hasan_polatkan
fi
if [[ "$mapLoaction" = 2 ]]
then
location=41.26536359,28.73788365
mac=2
map=2
helpMap=$istanbul_airport
fi
if [[ "$mapLoaction" = 3 ]]
then
location=35.71821892,-120.77333828
mac=3
map=3
helpMap=$mcmillan_airport
fi

if [[ "$realMap" = "false" ]]
then
map=4
fi

#Json veri girişi dont touch
udp=$startUDP-5
sayac=0
rm -r ./json
mkdir json
while [ $sayac -le 11 ]
do
sayac=$((sayac+1))
echo '{
   "long": 0,
   "lat": 0,
   "alt": 0
}' > ./json/$((udp=udp+10)).json
done
((udp=udp-120))

#script yardımcısı dont touch
if [ "$1" == "-h" ]
then
udp_port_list=("${YELLOW}  _______  ______   _____  _______      _    _   _____  _    _   _____  _    _ 
 |__   __||  ____| / ____||__   __|    | |  | | / ____|| |  | | / ____|| |  | |
    | |   | |__   | (___     | |       | |  | || |     | |  | || (___  | |  | |
    | |   |  __|   \___ \    | |       | |  | || |     | |  | | \___ \ | |  | |
    | |   | |____  ____) |   | |       | |__| || |____ | |__| | ____) || |__| |
    |_|   |______||_____/    |_|        \____/  \_____| \____/ |_____/  \____/ 
${ENDCOLOR}Zephry Camera Link ${GREEN}"http://0.0.0.0:8080/stream?topic=/zephyr/image_raw"${ENDCOLOR}
Cessna Camera Link ${GREEN}"http://0.0.0.0:8080/stream?topic=/cessna/image_raw"${ENDCOLOR} ${BLUE}
UDP Ports        Telemetry     For Bot / For Using${ENDCOLOR}
Cessna Camera    $((udp=udp+5))         $((udp=udp+5))${BLUE}
Zephry Camera    $((udp=udp+5))         $((udp=udp+5))${ENDCOLOR}
Cessna 1         $((udp=udp+5))         $((udp=udp+5))${BLUE}
Cessna 2         $((udp=udp+5))         $((udp=udp+5))${ENDCOLOR}
Cessna 3         $((udp=udp+5))         $((udp=udp+5))${BLUE}
Cessna 4         $((udp=udp+5))         $((udp=udp+5))${ENDCOLOR}
Zephry 1         $((udp=udp+5))         $((udp=udp+5))${BLUE}
Zephry 2         $((udp=udp+5))         $((udp=udp+5))${ENDCOLOR}
Zephry 3         $((udp=udp+5))         $((udp=udp+5))${BLUE}
Zephry 4         $((udp=udp+5))         $((udp=udp+5))${ENDCOLOR}
Vtol             $((udp=udp+5))         $((udp=udp+5))")
echo -e "$udp_port_list"
((udp=udp-110))
read -p "Press enter to continue"
clear
echo -e "$helpMap"
read -p "Press enter to continue"
fi

c=-1
#mapa göre start verme dont touch
if [[ "$mapType" = "vehicle" ]]
then
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
fi

if [[ "$mapType" = "vehicles" ]]
then
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
gnome-terminal -- python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyrMaster.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
gnome-terminal -- python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/quadplane.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff -v 1"
fi

if [[ "$mapType" = "frozen" ]]
then
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyrMaster.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -b $botType -s $startUDP -d $botdiff"
fi

#video ve gazeboyu başlatma
screen -S server -d -m bash -c "rosrun web_video_server web_video_server"
screen -S simulation -T -d -m bash -c "roslaunch ~/test-ucusu/fighter-sim/worlds/launcher.launch world:=$map-$mapType.world gui:=$gazeboGui"

#log temizleme
if [[ "$clear" = "enable" ]]
then
rm -r eeprom.bin
rm -r mav.*
rm -r logs
rm -r json
rm -r terrain
fi

#sistemi kapatma dont touch
killall screen
pkill -9 -f bot.py
pkill -9 -f sim_vehicle.py
pkill -9 -f mavproxy.py
pkill -9 -f arduplane
