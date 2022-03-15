#!/bin/bash

BLUE="\e[36m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
RED="\e[91m"
YELLOW="\e[93m"

udp=("14700-5")
if [ 0$1 -gt "0" ] ;
then
udp=("$1-5")
fi

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
Vtol             $((udp=udp+5))         $((udp=udp+5))${RED}
If you want to change UDP adress, write first UDP adress when start this script.${ENDCOLOR}")

echo -e "$udp_port_list"

((udp=udp-110))

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
41.27344964 36.54494403   teknofest_h${ENDCOLOR}
")
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
39.82828815 30.49662495   teknofest_h${ENDCOLOR}
")
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
41.28384374 28.71493156  teknofest_h${ENDCOLOR}
")
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
35.72341750 -120.77420400  teknofest_h${ENDCOLOR}
")
export PS3="\e[0;36m[\u@\h \W]\$ \e[m "
PS3='Choose your map option: '
opt=("Standart Map Only Location" "Real Map with Location")
select opt in "${opt[@]}"
do
    case $opt in
    "Standart Map Only Location")
            PS3='Choose your airport location: '
            opt=("Samsun Carsamba Airport" "Eskisehir Hasan Polatkan Airport" "Istanbul Airport")
            select opt in "${opt[@]}"
                do
                    case $opt in
                    "Samsun Carsamba Airport")
                        location=41.25496844,36.56789256
                        map=4
                        mac=0
                        echo -e "${samsun_carsamba}"
                        break
                        ;;
                    "Eskisehir Hasan Polatkan Airport")
                        location=39.80979394,30.51907959
                        map=4
                        mac=1
                        echo -e "${hasan_polatkan}"
                        break
                        ;;
                    "Istanbul Airport")
                        location=41.26536359,28.73788365
                        map=4
                        mac=2
                        echo -e "${istanbul_airport}"
                        break
                        ;;
                    esac
            done
                       break
                        ;;
    "Real Map with Location")
            PS3='Choose your airport location: '
            opt=("Samsun Carsamba Airport" "Eskisehir Hasan Polatkan Airport" "Istanbul Airport" "Mcmillan Airfield")
            select opt in "${opt[@]}"
            do
                 case $opt in
                    "Samsun Carsamba Airport")
                        location=41.25496844,36.56789256
                        map=0
                        mac=0
                        echo -e "${samsun_carsamba}"
                        break
                        ;;
                    "Eskisehir Hasan Polatkan Airport")
                        location=39.80979394,30.51907959
                        map=1
                        mac=1
                        echo -e "${hasan_polatkan}"
                        break
                        ;;
                    "Istanbul Airport")
                        location=41.26536359,28.73788365
                        map=2
                        mac=2
                        echo -e "${istanbul_airport}"
                        break
                        ;;
                    "Mcmillan Airfield")
                        location=35.71821892,-120.77333828
                        map=3
                        mac=3
                        echo -e "${mcmillan_airport}"
                        break
                        ;;
                esac
            done
            break
            ;;
    esac
done


c=-1

PS3='Map Type: '
opt2=("Empty" "Vehicle" "Vehicle with Enemies" "Vehicle with Frozen Enemies")
select opt in "${opt2[@]}"
do
    case $opt in
        "Empty")
            map2=empty
            break
            ;;
        "Vehicle")
            map2=vehicle
            PS3='Do you want to use QR bot?: '
            opt3=("Yes" "No")
            select opt in "${opt3[@]}"
            do
                case $opt in
                "Yes")
                    screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                    screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -b 1 -p $udp"
                    screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                    screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -b 1 -p $udp"
                    break
                    ;; 
                "No")
                   screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                   screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                    break
                    ;;
                esac
            done
                    break
                    ;;
        "Vehicle with Enemies")
            map2=vehicles
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            #screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            #screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
            screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/quadplane.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
            screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp -v 1"
            break
            ;;
        "Vehicle with Frozen Enemies")
            map2=frozen
            PS3='Do you want to use bot?: '
            opt3=("Yes" "No")
            select opt in "${opt3[@]}"
            do
                case $opt in
                "Yes")
                    screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                    screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
                    screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                    screen -S bot -d -m bash -c "python3 ~/test-ucusu/fighter-sim/bot.py -m $mac -p $udp"
                    break
                    ;; 
                "No")
                   screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/cessna.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                   screen -S vehicle -d -m bash -c "sim_vehicle.py -v ArduPlane -f gazebo-zephyr --add-param-file ~/test-ucusu/fighter-sim/params/zephyr.parm  -m --mav20 -I$((c=c+1)) --out=127.0.0.1:$((udp=udp+5)) --out=127.0.0.1:$((udp=udp+5)) -l $location,0,0"
                        break
                        ;;
                esac
            done
            break
            ;;
    esac
done
screen -S server -d -m bash -c "rosrun web_video_server web_video_server"
screen -S simulation -T -d -m bash -c "roslaunch ~/test-ucusu/fighter-sim/worlds/launcher.launch world:=$map-$map2.world"
killall screen
