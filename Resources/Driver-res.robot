*** Settings ***
Library     AppiumLibrary
Library     BuiltIn
#Library     SeleniumLibrary
Library     Swiping
Library     Process
Resource    Data.robot
Resource    Android-res.robot

*** Variables ***
#*** Test variables ***
&{Driver}       Num=${Driver_Number}    OTP=${Driver_OTP}
&{Car}          Plate=${Car_Plate}  Mileage=${Car_Mileage}  Brand=${Vehicle_Brand}  Type=${Vehicle_Type}
&{Trip}         Destination=${Destination}        Speed=${Speed}

#*** Home Driver Screen ***
${Home_Icon}    id=${AppPackage}:id/driver_home_fragment
${Points_Bar}   id=${AppPackage}:id/points_holder

#*** Start Trip Screen ***
${Ok_Mock_Location_Button}              id=ru.gavrikov.mocklocations:id/help_win_ok
${My_Location_Button}                   //android.widget.ImageView[@content-desc="My Location"]
${Start_Location}                       //hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/androidx.drawerlayout.widget.DrawerLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout[2]/android.widget.ImageView
${Search_Icon}                          //android.widget.EditText[@text="Type an address"]
${Search_Mark}                          ru.gavrikov.mocklocations:id/btsearch_mc
${Check_Mark_Location}                  id=ru.gavrikov.mocklocations:id/AddMarkerCheckBox
${Search_Ok_Button}                     id=ru.gavrikov.mocklocations:id/open_button
${Done_Mark}                            id=ru.gavrikov.mocklocations:id/thre_button
${Settings_Button}                      id=android:id/button1
${Select_Mock_Location}                 //android.widget.TextView[@text="Select mock location app"]
${Specify_Speed_Field}                  id=ru.gavrikov.mocklocations:id/input_name_route_editText
${Go_Button}                            id=ru.gavrikov.mocklocations:id/start_servise_button

#*** Driver Home-Screen ***
${Start_Shift_Button}           id=${AppPackage}:id/start_shift_button
${Select_Vehicle_ToDrive}       //android.widget.TextView[@text="235D4D"]
${Enable_Location_Button}       id=${AppPackage}:id/enableButton
${Enable_Location_ButtonSamsungA22}     com.android.permissioncontroller:id/allow_always_radio_button
${Back_Button}                  //android.widget.ImageButton[@content-desc="Back"]
${Allow_All_Time_Button}        id=com.android.permissioncontroller:id/permission_allow_button
${Start_Driving_Button}         com.dsquares.mobilcare.test:id/checkList_startDriving

#*** Profile Driver Screen ***
${Logout_Button}    id=${AppPackage}:id/logoutTv
${Unregistered_Page_Message}    id=${AppPackage}:id/phoneHeaderTv
${Driver_Avatar_Icon}      id=${AppPackage}:id/driverAvatar

#*** End Shift ***
${End_Shift_Button}         com.dsquares.mobilcare.test:id/trip_endShift
${Retry_Button}             com.dsquares.mobilcare.test:id/send
${Distance_plate}=  Get Text      com.dsquares.mobilcare.test:id/tripResult_driver_mileage
${OK_Button}            com.dsquares.mobilcare.test:id/tripResult_ok
${Like_Button}          com.dsquares.mobilcare.test:id/tripFeedback_approved
${FeedBack_OK_Button}   com.dsquares.mobilcare.test:id/tripFeedback_ok
*** Keywords ***

Login with Driver Account
    [Arguments]     ${Num}      ${OTP}
    Input User Number and Click Continue        ${Num}
    Input OTP and Click Continue                ${OTP}

Login Driver Successful
    Wait Until Page Contains Element    ${Home_Icon}    15
    Wait Until Page Contains Element    ${Points_Bar}   15

Logout with Driver User
    Click Element                       ${Driver_Avatar_Icon}
    Wait Until Page Contains Element    ${Logout_Button}
    Click Element                       ${Logout_Button}
    Wait Until Page Contains Element    ${Logout_Button}
    Click Element                       ${Logout_Button}

Login again with Just Logged Driver Account
    [Arguments]     ${Num}
    Input User Number and Click Continue        ${Num}
    OTP Just Sent in One Minute

Make a trip with Mock Location
    [Arguments]  ${Destination}     ${Speed}
    Open The Mock Location
    Detect My Location
    Select Destination and Speed and Go        ${Destination}      ${Speed}

Open The Mock Location
    Open The Mock Location Application
#    Grant Access Foreground Message
#    wait until page contains element    ${Allow_Access_Media_Button}
#    click element                       ${Allow_Access_Media_Button}
#    wait until page contains element    ${Ok_Mock_Location_Button}
#    click element                       ${Ok_Mock_Location_Button}

Detect My Location
    wait until page contains element    ${My_Location_Button}       20
    long press                          ${My_Location_Button}
    click element                       ${My_Location_Button}
#    Set the start location
    long press                          ${start_location}

Select Destination and Speed and Go
    [Arguments]  ${Destination}     ${Speed}
#    click element at coordinates        85      893
    Click element                       ${Search_Mark}
    wait until page contains element    ${search_icon}
    input text                          ${Search_Icon}      ${Destination}
#    click element                       ${Check_Mark_Location}
    swipe screen
    wait until page contains element    ${Search_Ok_Button}
    click element                       ${Search_Ok_Button}
    wait until page contains element    ${Done_Mark}    20
    click element                       ${Done_Mark}
    wait until page contains element    ${Specify_Speed_Field}
    clear text                          ${Specify_Speed_Field}
    input text                          ${Specify_Speed_Field}      ${Speed}
    click element                       ${go_button}

Set the start location
    set location            30.443326665545676   31.19021211755414

swipe screen
#    Press Keycode    3
    ${x1}=    Set Variable    350
    ${y1}=    Set Variable    610
    ${x2}=    Set Variable    300
    ${y2}=    Set Variable    440
    ${duration}=    Set Variable    500
    Swipe    ${x1}  ${y1}    ${x2}  ${y2}    duration=${duration}

Driver Starts the Trip
    wait until page contains element        ${start_shift_button}       5
    click element                           ${start_shift_button}
#    Set the start location
#    wait until page contains element        ${select_vehicle_todrive}   3
#    click element                           ${Select_Vehicle_ToDrive}
#    wait until page contains element        ${Enable_Location_Button}
#    Click element                           ${Enable_Location_Button}
#    click element                           ${Enable_Location_ButtonSamsungA22}
#    Click element                           ${Back_Button}
#    wait until page contains element        ${allow_all_time_button}
#    click element                           ${allow_all_time_button}
#    click element at coordinates            450  1900
    wait until page contains element        ${Start_Driving_Button}
    Click Element                           ${Start_Driving_Button}
#    click element at coordinates            300     440


Driver Ends the Trip
    Open The MobilCare Application
    Sleep    300s
    Click Element                           ${End_Shift_Button}
    Sleep    7s
    Click Element                           ${Retry_Button}
    Sleep    7s
    Click Element                           ${Retry_Button}
    Should Contain                          ${Distance_plate}       10
    Click Element                           ${OK_Button}
    Click Element                           ${Like_Button}
    Click Element                           ${FeedBack_OK_Button}
    Sleep    15s
    Element Should Be Visible               ${start_shift_button}