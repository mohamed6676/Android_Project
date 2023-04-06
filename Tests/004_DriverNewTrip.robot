*** Settings ***
Library     AppiumLibrary
Resource  ../Resources/Android-res.robot
Resource  ../Resources/Driver-res.robot


*** Test Cases ***
Driver starts a trip
    Open The MobilCare Application
##    Login with Driver Account                ${Driver}[Num]       ${Driver}[OTP]
##    Login Driver Successful
    Driver Starts the Trip
    Make a trip with Mock Location      ${Trip}[Destination]        ${Trip}[Speed]
    Driver Ends the Trip


