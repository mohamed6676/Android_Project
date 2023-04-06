*** Settings ***
Library  AppiumLibrary
Resource  ../Resources/Android-res.robot
Resource  ../Resources/Owner-res.robot

*** Test Cases ***
Add A Vehicle

    Open MobilCare Device
    Login with Owner Account    ${Owner}[Num]   ${Owner}[OTP]
    Login Owner Successful
    Click Add Vehicle Button and Fill the Fields    ${Car}[Plate]    ${Car}[Mileage]
    Select Vehicle Brand                ${Car}[Brand]
    Select Vehicle Type and proceed     ${Car}[Type]
    Attach a photo for the Vehicle
    Vehicle is added successfully
    Click Add Vehicle Button and Fill the Fields    ${Car}[Plate]    ${Car}[Mileage]
    Select Vehicle Brand                ${Car}[Brand]
    Select Vehicle Type and proceed     ${Car}[Type]
    Vehicle already was added


Adding already added Vehicle
    Login with Owner Account    ${Owner}[Num]    ${Owner}[OTP]
    Click Add Vehicle Button and Fill the Fields    ${Car_Plate}     ${Car_Mileage}
    Select Vehicle Brand        ${Vehicle_Brand}
    Select Vehicle Type and proceed    ${Vehicle_Type}
    Vehicle already was added


