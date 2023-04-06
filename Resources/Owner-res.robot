*** Settings ***
Library     AppiumLibrary
Resource    Data.robot
Resource    Android-res.robot

*** Variables ***
#*** Test Variables ***
&{Owner}        Num=${Owner_Number}     OTP=${Owner_OTP}

#*** Home Owner Screen ***
${Profile_Icon}     id=${AppPackage}:id/operatorNav_profile
${Vehicles_Icon}    //android.widget.FrameLayout[@content-desc="Vehicles"]/android.widget.ImageView

#*** Add Vehicles Screen ***
${Add_Vehicle_Button}                   id=${AppPackage}:id/vehicleOverview_addVehicle
${License_Plate_Number_Field}           //android.widget.EditText[@text="License Plate Number"]
${Current_Mileage_Field}                //android.widget.EditText[@text="Current Mileage"]
${Vehicle_Brand_Button}                 id=${AppPackage}:id/addVehicle_brand_editText
${Select_Vehicle_Brand}                 //android.widget.TextView[@text="${Vehicle_Brand}"]
${Vehicle_Type_Button}                  //android.widget.EditText[@text="Vehicle Type"]
${Select_Vehicle_Type}                  //android.widget.TextView[@text="${Vehicle_Type}"]
${Next_Button}                          id=${AppPackage}:id/addVehicle_send
${Attach_Photo_Icon}                    id=com.deloitte.mobilcare.TEST:id/addVehiclePicture_addPicture
${Camera_Button_Icon}                   id=${AppPackage}:id/pictureSourceDialog_camera
${Add_Photo_Button}                     id=${AppPackage}:id/addVehiclePicture_add
${Vehicle_Added_Message}                //android.widget.TextView[@text="Vehicle added!"]
${OK_Button}                            id=${AppPackage}:id/vehicleAdded_accept
${Message_Vehicle_Exist}                //android.widget.TextView[@resource-id="android:id/message"]
${Message_Vehicle_Exist_Close_Button}   id=android:id/button3

#*** Profile Configuration ***
${Profile_Icon}                         Profile
${Upload_OwnerPhoto_Icon}               id=${AppPackage}:id/owner_profile_picture
${Edit_OwnerName_Button}                id=${AppPackage}:id/editNameTv
${Change_OwnerLanguage_Button}          id=${AppPackage}:id/changeLanguageTV

*** Keywords ***
Login with Owner Account
    [Arguments]     ${Num}  ${OTP}
    Input User Number and Click Continue        ${Num}
    Input OTP and Click Continue                ${OTP}

Login Owner Successful
    Wait Until Page Contains Element    ${Profile_Icon}     15
    Wait Until Page Contains Element    ${Vehicles_Icon}    15

Logout with Owner User
    Click Element                       ${Profile_Icon}
    Wait Until Page Contains Element    ${Logout_Button}    10
    Click Element                       ${Logout_Button}
    Wait Until Page Contains Element    ${Logout_Button}
    Click Element                       ${Logout_Button}
    Wait Until Page Contains Element    ${Unregistered_Page_Message}

Login again with Just Logged Owner Account
    [Arguments]     ${Num}
    Input User Number and Click Continue        ${Num}
    OTP Just Sent in One Minute

Click Add Vehicle Button and Fill the Fields
    [Arguments]  ${Car_Plate}   ${Car_Mileage}
    Click Element                       ${Add_Vehicle_Button}
    Wait Until Page Contains Element    ${License_Plate_Number_Field}
    Input Text                          ${License_Plate_Number_Field}       ${Car_Plate}
    Input Text                          ${Current_Mileage_Field}            ${Car_Mileage}

Select Vehicle Brand
    [Arguments]  ${Car_Brand}
    Click Element                       ${Vehicle_Brand_Button}
    Click Element                       ${Select_Vehicle_Brand}

Select Vehicle Type and proceed
    [Arguments]   ${Car_Type}
    Click Element                       ${Vehicle_Type_Button}
    Click Element                       ${Select_Vehicle_Type}
    Click Element                       ${Next_Button}

Attach a photo for the Vehicle
    Wait Until Page Contains Element    ${Attach_Photo_Icon}
    Click Element                       ${Attach_Photo_Icon}
    Click Element                       ${Camera_Button_Icon}
    Wait Until Page Contains Element    ${Permission_Button}
    Click Element                       ${Permission_Button}
    Wait Until Page Contains Element    ${Allow_Access_Media_Button}
    Click Element                       ${Allow_Access_Media_Button}
    Wait Until Page Contains Element    ${Camera_Shutter_Button}
    Wait Until Page Contains Element    ${Camera_Shutter_Button}
    Click Element                       ${Camera_Shutter_Button}
    Wait Until Page Contains Element    ${Mark_Done_Button}     7
    Click Element                       ${Mark_Done_Button}

Vehicle is added successfully
    Wait Until Page Contains Element    ${Add_Photo_Button}
    Click Element                       ${Add_Photo_Button}
    Wait Until Page Contains Element    ${Vehicle_Added_Message}
    Click Element                       ${OK_Button}

Vehicle already was added
    wait until page contains element        ${Message_Vehicle_Exist}
    click element                           ${Message_Vehicle_Exist_Close_Button}
