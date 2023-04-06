*** Settings ***
Library  AppiumLibrary
Resource  ../Resources/Android-res.robot
Resource  ../Resources/Driver-res.robot

*** Test Cases ***

Login As Driver
    Open MobilCare Device
    Login with Driver Account                ${Driver}[Num]       ${Driver}[OTP]
    Login Driver Successful

Login with just loggedIn Driver
    Open MobilCare Device
#    Login with Driver Account                ${Driver}[Num]       ${Driver}[OTP]
#    Login Driver Successful
#    Logout with Driver User
    Login again with Just Logged Driver Account        ${Driver}[Num]