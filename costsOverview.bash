#!/bin/bash

##declaration of Variables

#path to saving files
SavingFile=/home/tobias/TestSkripte/SpeicherBuchhaltung

Budget=$(cut -d= -f2 $SavingFile)
CostsHousehold=$(cut -d= -f4 $SavingFile)
CostsCar=$(cut -d= -f6 $SavingFile)
CostsLuxury=$(cut -d= -f8 $SavingFile)
CostsStudy=$(cut -d= -f10 $SavingFile)
CostsFood=$(cut -d= -f12 $SavingFile)
CostsHygiene=$(cut -d= -f14 $SavingFile)
CostsEntertainment=$(cut -d= -f16 $SavingFile)
CostsOther=$(cut -d= -f18 $SavingFile)
CostsMonthly=$(cut -d= -f20 $SavingFile)
CostsAll=$(cut -d= -f22 $SavingFile)
CostsMonthlyOld=

# check if script is called with parameters - if not show current budget
if [ $# -gt 0 ]
then
        case $1 in
                # add amount to *Costs and subtract it from the given budget
                "-a")
                        case $2 in
                               #asigning variables for chosen *Costs
                                #for adding *Costs only change or append lines in case statement
                                "-h") CostsTemp=$CostsHousehold; CostsName=CostsHousehold;;
                                "-c") CostsTemp=$CostsCar; CostsName=CostsCar;;
                                "-l") CostsTemp=$CostsLuxury; CostsName=CostsLuxury;;
                                "-s") CostsTemp=$CostsStudy; CostsName=CostsStudy;;
                                "-f") CostsTemp=$CostsFood; CostsName=CostsFood;;
                                "-y") CostsTemp=$CostsHygiene; CostsName=CostsHygiene;;
                                "-e") CostsTemp=$CostsEntertainment; CostsName=CostsEntertainment;;
                                "-o") CostsTemp=$CostsOther; CostsName=CostsOther;;


                        esac;
                        #add given amount to chosen *Costs
                        CostsNew=$((CostsTemp+$3));
                         #save new Costs
                        sed -i "s/$CostsName=$CostsTemp/$CostsName=$CostsNew/g" "$SavingFile";
                        #save new calculated Budget to file
                        BudgetNew=$((Budget-$3));
                        sed -i "s/Budget=$Budget/Budget=$BudgetNew/g" "$SavingFile";;

                #change the value of Budget or *Costs
                "--change")
                        #check if there are three options given --> if not you cant add costs
                        if [ $# -eq 3 ] ; then

                                #check input what shall be changed, if wanted only change/add options here
                                case $2 in
                                        "-b") nameTemp=Budget; changeTemp=$Budget;;
                                        "-h") nameTemp=CostsHousehold; changeTemp=$CostsHousehold;;
                                        "-c") nameTemp=CostsCar; changeTemp=$CostsCar;;
                                        "-l") nameTemp=CostsLuxury; changeTemp=$CostsLuxury;;
                                        "-s") nameTemp=CostsStudy; changeTemp=$CostsStudy;;
                                        "-f") nameTemp=CostsFood; changeTemp=$CostsFood;;
                                        "-y") nameTemp=CostsHygiene; changeTemp=$CostsHygiene;;
                                        "-e") nameTemp=CostsEntertainment; changeTemp=$CostsEntertainment;;
                                        "-o") nameTemp=CostsOther; changeTemp=$CostsOther;;
                                esac;

                                #changing the values in the saving File
                                sed -i "s/$nameTemp=$changeTemp/$nameTemp=$3/g" "$SavingFile"
                        #print error if there are not three options given
                        else
                                printf "%-s \n"  "no value given, please run again with value"
                        fi;;


                #print wanted costs
                "--print")

                        #assigning variables for case statement so they can be printed wiht -t otherwise they could be printed in case statement directly without variables
                        printB="Amount of Budget: $Budget"
                        printH="Household costs: $CostsHousehold"
                        printC="Car costs: $CostsCar"
                        printL="Luxury costs: $CostsLuxury"
                        printS="Sutdy costs: $CostsStudy"
                        printF="Food costs: $CostsFood"
                        printY="Hygine costs: $CostsHygiene"
                        printE="Enternainment costs: $CostsEntertainment"
                        printO="Other costs: $CostsOther"
                        printA="All costs added together are: $((CostsHousehold + CostsCar + CostsLuxury + CostsStudy + CostsFood + CostsHygiene + CostsEntertainment + CostsOther))"



                        case $2 in
                                "-b") printf "%s \n" "$printB";;
                                "-h") printf "%s \n" "$printH";;
                                "-c") printf "%s \n" "$printC";;
                                "-l") printf "%s \n" "$printL";;
                                "-s") printf "%s \n" "$printS";;
                                "-f") printf "%s \n" "$printF";;
                                "-y") printf "%s \n" "$printY";;
                                "-e") printf "%s \n" "$printE";;
                                "-o") printf "%s \n" "$printO";;
                                "-a") printf "%s \n" "$printA";;
                                "-t") printf "%s \t \t" "$printH"; printf "%-s \n" "$printC";
                                      printf "%s \t \t" "$printL"; printf "%-s \n" "$printS";
                                      printf "%s \t \t" "$printF";  printf "%-s \n" "$printY";
                                      printf "%s \t " "$printE";  printf "%-s \n" "$printO";
                                      printf "%s \n" "$printA";
                                      printf "%s \n" "$printB";;

                        esac;;



                #shows help; if new *Cost is changed/added, change help option too so it stays up to date
                "--help")
                        #adding costs
                        printf "%-s \n \t" "-a: add following costs:";
                        printf "%-s \n \t" "-h: Household related costs";
                        printf "%-s \n \t" "-c: car related costs";
                        printf "%-s \n \t" "-l: luxury related costs";
                        printf "%-s \n \t" "-s: stutdy related costs";
                        printf "%-s \n \t" "-f: food related costs";
                        printf "%-s \n \t" "-y: hygiene article related costs";
                        printf "%-s \n \t" "-e: entertainment related costs";
                        printf "%-s \n \n" "-o: other related costs";
                        #change costs
                        printf "%-s \n \t" "--change: change the value of the following costs:";
                        printf "%-s \n \t" "-b:  budget";
                        printf "%-s \n \t" "-h: household";
                        printf "%-s \n \t" "-c: car";
                        printf "%-s \n \t" "-l: luxury";
                        printf "%-s \n \t" "-s: study";
                        printf "%-s \n \t" "-y: hygiene";
                        printf "%-s \n \t" "-e: entertainment";
                        printf "%-s \n \n"   "-o: other";
                        #show costs
                        printf "%-s \n \t" "--print: prints following costs:";
                        printf "%-s \n \t" "-b:  budget";
                        printf "%-s \n \t" "-h: household";
                        printf "%-s \n \t" "-c: car";
                        printf "%-s \n \t" "-l: luxury";
                        printf "%-s \n \t" "-s: study";
                        printf "%-s \n \t" "-y: hygiene";
                        printf "%-s \n \t" "-e: entertainment";
                        printf "%-s \n \t" "-o: other";
                        printf "%-s \n \t" "-a: all costs added together";
                        printf "%-s \n \t" "-t: print all costs and budget";;



        esac

else
       printf "%-s \n" $Budget
fi
