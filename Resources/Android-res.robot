*** Settings ***
Library     AppiumLibrary
Resource    Data.robot
Resource    Driver-res.robot

Documentation  ***MobilCare Application***

*** Variables ***

#*** Device Details ***
#*** Port ***
${Appium_Port_Device1}      4723
${Appium_Port_Device2}      4725
#*** Name ***
${deviceOne}    emulator-5554
${deviceTwo}    emulator-5556
${RealDevice}   5LLRK7HYQ4PVQ4EI
${SAMSUNG_A22}   R58RC39DSRD

#*** ***
${Permission_Button}                    id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
${Allow_Access_Media_Button}            id=com.android.permissioncontroller:id/permission_allow_button
${Camera_Shutter_Button}                id=com.android.camera2:id/shutter_button
${Mark_Done_Button}                     id=com.android.camera2:id/done_button

#*** Application Variables ***
${AppPackage}           com.dsquares.mobilcare.staging
${AppActivity}          com.dsquares.mobilcare.launch.LaunchActivity

#*** Login Screen ***
${Foreground_Permission_Button}  id=com.android.permissioncontroller:id/permission_allow_foreground_only_button
${Phone_Number_Field}  id=${AppPackage}:id/login_editText
${Continue-Button}  id=${AppPackage}:id/continue_button
${OTP_Just_Sent_Message}    //android.widget.TextView[@text="OTP can not be send right now please wait: 1 minutes"]
${OTP_Just_Sent_Button}     //android.widget.Button[@text="CLOSE"]

#*** OTP Screen ***
${OTP_Field}  id=${AppPackage}:id/otp_pin_view
${Continue_Button}  id=${AppPackage}:id/continue_button



*** Keywords ***
Open The MobilCare Application
    [Arguments]     ${Appium_Port}=${Appium_Port_Device1}      ${deviceName}=${SAMSUNG_A22}
    Open Application    http://localhost:${Appium_Port}/wd/hub    platformName=android   deviceName=${deviceName}    appPackage=com.dsquares.mobilcare.staging    appActivity=com.dsquares.mobilcare.launch.LaunchActivity   automationName=Uiautomator2   noReset=true

Open The Mock Location Application
    open Application    http://localhost:${Appium_Port_Device1}/wd/hub     platformName=android    deviceName=${deviceOne}     appPackage=ru.gavrikov.mocklocations        appActivity=ru.gavrikov.mocklocations.MainActivity       automationName=Uiautomator2     noReset=true

Open MobilCare Device
#    Open The MobilCare Application      ${Appium_Port_Device1}      ${deviceOne}
    Open The MobilCare Application
    Grant Access Foreground Message

Grant Access Foreground Message
    Wait Until Page Contains Element        ${Foreground_Permission_Button}
    Click Element                           ${Foreground_Permission_Button}

OTP Just Sent in One Minute
    wait until page contains element        ${OTP_Just_Sent_Message}
    click element                           ${OTP_Just_Sent_Button}

Input User Number and Click Continue
    [Arguments]     ${Num}
    Wait Until Page Contains Element    ${Phone_Number_Field}   10
    Input Text                          ${Phone_Number_Field}   ${Num}
    Click Element                       ${Continue_Button}

Input OTP and Click Continue
    [Arguments]     ${OTP}
    Wait Until Page Contains Element    ${OTP_Field}        15
    Input Text                          ${OTP_Field}           ${OTP}
    Click Element                       ${Continue_Button}



