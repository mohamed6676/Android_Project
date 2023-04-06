*** Settings ***
Library  AppiumLibrary
Resource  ../Resources/Android-res.robot
Resource  ../Resources/Owner-res.robot

*** Test Cases ***

Login As Owner
    Open MobilCare Device
    Login with Owner Account                ${Owner}[Num]       ${Owner}[OTP]
    Login Owner Successful

Login with just loggedIn Owner
    Open MobilCare Device
#    Login with Owner Account                ${Owner}[Num]       ${Owner}[OTP]
#    Login Owner Successful
#    Logout with Owner User
    Login again with Just Logged Owner Account      ${Owner}[Num]