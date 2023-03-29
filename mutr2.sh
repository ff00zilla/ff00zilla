#!/bin/bash

#####################################################
#    M.U.T.R.2 - MUltiprotocol TraceRoute v2.0      #
# This program was designed to allow traceroute via #
# various network protocols. AI used for debugging. #
#             Written by ff00 @2023                 #
#####################################################
# NOTE: to make the script working properly, you    #
#       need to have traceroute installed.          #
#####################################################
#    Usage: ~$sudo ./mutr2.sh www.example.com       #
#           ~$sudo ./mutr2.sh 1.2.3.4               #
#####################################################

# Get the destination from the command line argument
destination=$1

# Check if destination is provided
if [ -z "$destination" ]
then
    echo "Usage: $0 <destination>"
    exit 1
fi

# Clear the terminal from previous lines
clear

# Define function to perform traceroute for a specific protocol
function traceroute_protocol {
    protocol=$1
    echo "****************"
    echo "$protocol Traceroute:"
    echo "****************"
    traceroute $2 -n -m $max_hops $destination
}

# Ask the user for the maximum number of hops
   read -p "Enter the maximum number of hops (just press Enter for default-max=255) for target $destination: " max_hops
   if [ -z "$max_hops" ]
   then
    max_hops=255
fi


# Show menu to select whether to traceroute all protocols or manually
clear
echo "***********************************************"
echo "M.U.T.R.2"
echo "**********"
echo "Protocols Available: TCP,UDP,ICMP,GRE,SCTP,DCCP"
echo "Target: $destination"
echo "Maximum Hops: $max_hops"
echo "***********************************************"
echo "Select Mode:"
echo "************"
echo "1. All protocols automatically"
echo "2. Select specific protocol(s)"
echo ""
read -p "Enter choice: " trace_mode
echo "-------------"
echo ""

# Traceroute all protocols automatically
if [ "$trace_mode" == "1" ]
then
    traceroute_protocol "TCP" "-T"
    traceroute_protocol "UDP" "-U"
    traceroute_protocol "ICMP" "-I"
    traceroute_protocol "GRE" "-g 47"
    traceroute_protocol "SCTP" "-P sctp"
    traceroute_protocol "DCCP" "-D"
    
# Show menu to select protocols manually
elif [ "$trace_mode" == "2" ]
    then
    echo "******************"    
    echo "Select protocol(s) (separated by space):"
    echo "******************"
    echo "1. TCP"
    echo "2. UDP"
    echo "3. ICMP"
    echo "4. GRE"
    echo "5. SCTP"
    echo "6. DCCP"
    echo ""
    read -p "Enter choice(s): " protocol_choices
    echo "----------------"
    echo ""

    # Loop through selected protocols and call traceroute_protocol function
    for choice in $protocol_choices
    do
        case $choice in
            1)
                traceroute_protocol "TCP" "-T"
                ;;
            2)
                traceroute_protocol "UDP" "-U"
                ;;
            3)
                traceroute_protocol "ICMP" "-I"
                ;;
            4)
                traceroute_protocol "GRE" "-g 47"
                ;;
            5)
                traceroute_protocol "SCTP" "-P sctp"
                ;;
            6)
                traceroute_protocol "DCCP" "-D"
                ;;
            *)
                echo "------------------------"
                echo " Invalid Input - Quit !"
                ;;
        esac
    done
fi
echo "------------------------"
echo "          END           "
echo "------------------------"
echo " M.U.T.R.2 by ff00 @2023"
echo "------------------------"
