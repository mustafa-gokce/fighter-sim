import json
from doctest import master
from dronekit import LocationGlobalRelative, connect
import time
import random
import argparse
import math
import geopy.distance
import colorama
from colorama import Fore, Back, Style

colorama.init()

ap = argparse.ArgumentParser()
ap.add_argument("-m","--map",required=True,help="samsun 0, eskisehir 1, istanbul 2, 3 mcmillian 3")
ap.add_argument("-p","--port",required=True,help="port adress")
ap.add_argument("-v","--vehicle",required=False,help="for vtol write somethink")
ap.add_argument("-b","--bottype",required=False,help="0 for Fighter UAV, 1 for Kamikaze")
args = vars(ap.parse_args())

print(Fore.LIGHTGREEN_EX, "Vehicle Port Number is:", Fore.LIGHTCYAN_EX , (args["port"]))

#required to identify the vehicle type
if int(args["port"]) == 14705 or int(args["port"]) == 14715:
    master = 1
else:
    master = 0

if int(args["map"]) == 0:
    #samsun_airport
    def world ():
        global latmin, latmax, longmin, longmax, qr_1, qr_2, qr_3, qr_4 
        latmin=41.2714445
        latmax=41.2745409
        longmin=36.5420616
        longmax=36.5481234
        qr_1=41.27371117,36.54610957
        qr_2=41.27346260,36.54614445
        qr_3=41.27303270,36.54732937
        qr_4=41.27344964,36.54494403
        
if int(args["map"]) == 1:
    #hasan_polatkan
    def world ():
        global latmin, latmax, longmin, longmax, qr_1, qr_2, qr_3, qr_4 
        latmin=39.8265502
        latmax=39.8296400
        longmin=30.4944742
        longmax=30.5004072
        qr_1=39.82853660,30.49775910
        qr_2=39.82830170,30.49775910
        qr_3=39.82786821,30.49895444
        qr_4=39.82828815,30.49662495
        
if int(args["map"]) == 2:
    #istanbul_airport
    def world ():
        global latmin, latmax, longmin, longmax, qr_1, qr_2, qr_3, qr_4 
        latmin=41.2823619
        latmax=41.2855142
        longmin=28.7133372
        longmax=28.7196565
        qr_1=41.28410826,28.71609380
        qr_2=41.28386131,28.71612960
        qr_3=41.28342268,28.71732269
        qr_4=41.28384374,28.71493156
        
if int(args["map"]) == 3:
    #mcmillan_airfield
    def world ():
        global latmin, latmax, longmin, longmax, qr_1, qr_2, qr_3, qr_4 
        latmin=35.7218833
        latmax=35.7250364
        longmin=-120.7716107
        longmax=-120.7774687
        qr_1=35.72285994,-120.77583165
        qr_2=35.72385209,-120.77488093
        qr_3=35.72337693,-120.77278143
        qr_4=35.72341750,-120.77420400
#wait for starting simulation        
time.sleep(20)
vehicle = connect ('127.0.0.1:'+args["port"], wait_ready=True)

def arm_and_takeoff(aTargetAltitude):
    print ("Basic pre-arm checks")
    while not vehicle.is_armable:
        print (" Waiting for vehicle to initialise...")
        time.sleep(1)
    #for standart plane
    if args["vehicle"] is None:
        print ("Arming motors")
        vehicle.mode    = "TAKEOFF"
        vehicle.armed   = True
        time.sleep(15)
        vehicle.mode    = "GUIDED"
        vehicle.armed   = True
    #for vtol
    if not args["vehicle"] is None:
        print ("Arming motors")
        vehicle.mode    = "GUIDED"
        vehicle.armed   = True
        while not vehicle.armed:
            print (" Waiting for arming...")
            time.sleep(1)
        print ("Taking off!")
        vehicle.simple_takeoff(aTargetAltitude)
        while True:
            if vehicle.location.global_relative_frame.alt>=aTargetAltitude*0.95:
                print ("Reached target altitude")
                break
            time.sleep(1)

arm_and_takeoff(30)
world ()

qr_location = [ qr_1, qr_2, qr_3, qr_4 ]
print("Takeoff Complete")

sayac = 0
# bot types
if args["bottype"] is None:
    if master == 0:
        while True:
            if sayac%20 == 0:
                print("Change Location...")
                a_location = LocationGlobalRelative(random.uniform(latmin,latmax), random.uniform(longmin,longmax), random.randint(30,100))
                vehicle.simple_goto(a_location)
                print (a_location)
            time.sleep (1)
            sayac = sayac + 1
            location ={
    "long" :vehicle.location.global_frame.lon,
    "lat" :vehicle.location.global_frame.lat,
    "alt" :vehicle.location.global_relative_frame.alt
}
            json_object = json.dumps(location, indent = 3)
            filePathNameWExt = ('./' + "json" + '/' + str(args["port"]) + '.json')
            with open(filePathNameWExt, "w") as outfile:
                outfile.write(json_object)
    if master == 1:
        while True:
                    location ={
            "long" :vehicle.location.global_frame.lon,
            "lat" :vehicle.location.global_frame.lat,
            "alt" :vehicle.location.global_relative_frame.alt
        }
                    json_vehicle = json.dumps(location, indent = 3)
                    filePathNameWExt = ('./' + "json" + '/' + str(args["port"]) + '.json')
                    with open(filePathNameWExt, "w") as outfile:
                        outfile.write(json_vehicle)
                    if sayac%100 == 0:
                        print (Fore.LIGHTRED_EX + "******  Calculating Enemy Distance   ******")
                        enemyPort = 0
                        counter = 1
                        localCoords = (vehicle.location.global_frame.lat, vehicle.location.global_frame.lon)
                        enemiesDistance = []
                        while not counter%11 == 0:
                            counter = counter + 1
                            enemyPort = enemyPort + 10
                            filePathNameWExt = ('./' + "json" + '/' + (str(int(args["port"])+int(enemyPort))) + '.json')
                            with open(filePathNameWExt, 'r') as openfile:
                                enemy = json.load(openfile)
                            enemyCoords = (enemy["lat"], enemy["long"])
                            enemyLongLatDist = geopy.distance.geodesic(localCoords, enemyCoords).m
                            distance = math.sqrt(enemyLongLatDist**2+(vehicle.location.global_relative_frame.alt-enemy["alt"])**2)
                            enemiesDistance.append(distance)
                        selectBest = min(enemiesDistance)
                        enemyTarget = (int(enemiesDistance.index(selectBest))+1)*10
                        print(Fore.LIGHTGREEN_EX +"New Target Port Mumber:", int(args["port"])+int(enemyTarget))
                        #print(enemiesDistance)
                    filePathNameWExt = ('./' + "json" + '/' + (str(int(args["port"])+int(enemyTarget))) + '.json')
                    with open(filePathNameWExt, 'r') as openfile:
                        enemy = json.load(openfile)
                    enemyCoords = (enemy["lat"], enemy["long"])
                    localCoords = (vehicle.location.global_frame.lat, vehicle.location.global_frame.lon)
                    enemyLongLatDist = geopy.distance.geodesic(localCoords, enemyCoords).m
                    distance = math.sqrt(enemyLongLatDist**2+(vehicle.location.global_relative_frame.alt-enemy["alt"])**2)               
                    sayac = sayac + 1
                    print(Fore.WHITE , "-----------------------------------")
                    print(Fore.LIGHTGREEN_EX ,"Selected Enemy Port Mumber:", Fore.LIGHTCYAN_EX, int(args["port"])+int(enemyTarget))
                    print(Fore.LIGHTGREEN_EX ,"Distance to Enemy(m):", Fore.LIGHTCYAN_EX, distance)
                    print(Fore.LIGHTGREEN_EX ,"Speed:", Fore.LIGHTCYAN_EX, (math.sqrt(vehicle.velocity[0]**2 + vehicle.velocity[1]**2 + vehicle.velocity[2]**2)))
                    a_location = LocationGlobalRelative(enemy["lat"] ,enemy["long"] ,enemy["alt"])
                    vehicle.simple_goto(a_location)
                    print(Fore.LIGHTGREEN_EX , "Next WP:", Fore.LIGHTCYAN_EX,  enemy["lat"],enemy["long"],enemy["alt"])
                    time.sleep (1)
                    #print("Not found enemy. Change location...")
                    #a_location = LocationGlobalRelative(random.uniform(latmin,latmax), random.uniform(longmin,longmax), random.randint(30,100))
                    #vehicle.simple_goto(a_location)
                    #print (a_location)
                    #time.sleep(20) 

if  int(args["bottype"]) == 1:
    while True:
        a_location = LocationGlobalRelative(latmin, longmin, 100)
        vehicle.simple_goto(a_location)
        print("Change Location...")
        time.sleep(20)
        qr_lat,qr_min=random.choice(qr_location)
        location_2 = LocationGlobalRelative (qr_lat,qr_min,30)
        print("Change Location...")
        print (qr_lat , qr_min)
        vehicle.simple_goto(location_2)
        time.sleep(40)

if int(args["bottype"]) == 2:
    while True:
        a_location = LocationGlobalRelative(random.uniform(latmin,latmax), random.uniform(longmin,longmax), random.randint(30,100))
        vehicle.simple_goto(a_location)
        time.sleep(20)
