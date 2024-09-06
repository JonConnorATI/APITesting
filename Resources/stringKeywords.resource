*** Settings ***
Resource            all_resources.resource

*** Variables ***



*** Keywords ***

Create a random First Name
    ${firstName}  Create random string a-z only
    RETURN  ${firstName}

Create a random Last Name
    ${lastName}  Create random string a-z only
    RETURN  ${lastName}

Create a random Total Price
    ${totalPrice}  Generate Random String  4    [NUMBERS]09
    RETURN  ${totalPrice}

Create a Random Deposit Paid True or False
    ${bool} =  Evaluate    random.choice([0, 1])
    ${deposit_paid} =  Check True of False  ${bool}
    RETURN  ${deposit_paid}

Create a Random Check in Date
    ${time}  Get Current Date  time_zone=UTC
    ${CheckIn}  Convert Date  ${time}  result_format=%Y-%m-%d
    RETURN   ${CheckIn}

Create a Random Check out Date
    ${time}  Get Current Date  time_zone=UTC
    ${CheckIn}  Convert Date  ${time}  result_format=%Y-%m-%d
    ${CheckOut}  Add Time To Date    ${CheckIn}    7 days  result_format=%Y-%m-%d
    RETURN  ${CheckOut}

Create Random Additional Needs
    ${Additional_Needs}  Create random string a-z only
    RETURN  ${Additional_Needs}

Create random string a-z only
    [Documentation]  Creates a random a-z string of 7 letters
    ${Random_String}  Generate Random String  7    [UPPER]az
    RETURN  ${Random_String}

Check True of False
    [Documentation]  This returns True if the value passed in is '1' and 'False' if the value passed in is '0'
    [Arguments]  ${Check}
    Run Keyword If    '${Check}' == '1'    Return From Keyword    True
    Return From Keyword    False

Create a booking
    [Arguments]   ${first_name}=${None}  ${last_name}=${None}  ${totalPrice}=${None}  ${deposit_paid}=${None}  ${check_in}=${None}  ${check_out}=${None}  ${Add_needs}=${None}
    &{Booking_dates} =  Create Dictionary  checkin=${check_in}  checkout=${check_out}
    &{MainBody} =  Create Dictionary  firstname=${first_name}  lastname=${last_name}  totalprice=${totalPrice}
    ...            depositpaid=${deposit_paid}
    Set To Dictionary    ${MainBody}  bookingdates=${Booking_dates}
    Set To Dictionary    ${MainBody}  additionalneeds=${Add_needs}
    log  ${MainBody}
    RETURN  ${MainBody}

Create a booking with just additional needs to update
    [Arguments]   ${first_name}=${None}  ${last_name}=${None}
    &{MainBody} =  Create Dictionary  firstname=${first_name}  lastname=${last_name}
    log  ${MainBody}
    RETURN  ${MainBody}

Create random data for a valid booking request body
    [Documentation]  This creates the data for a valid booking
    ${firstName}  Create a random First Name
    ${lastName}  Create a random Last Name
    ${totalPrice}  Create a random Total Price
    ${deposit_paid} =  Create a Random Deposit Paid True or False
    ${CheckIn}  Create a Random Check in Date
    ${CheckOut}  Create a Random Check out Date
    ${Additional_Needs}  Create Random Additional Needs
    ${Request_body} =  Create a booking  ${firstName}  ${lastName}  ${totalPrice}  ${deposit_paid}
    ...                 ${CheckIn}  ${CheckOut}  ${Additional_Needs}
    RETURN  ${Request_body}

Create random data for a partial update booking request body
    [Documentation]  This creates the data to update the additional needs only
    ${firstName}  Create a random First Name
    ${lastName}  Create a random Last Name
    ${Request_body} =  Create a booking with just additional needs to update  ${firstName}  ${lastName}
    RETURN  ${Request_body}

Create the Log in Body for the request
    &{dictionary} =  Create Dictionary  username=${username}   password=${password}
    RETURN  ${dictionary}

Create the headers for the update request
    [Arguments]  ${token}
    &{dict} =  Create Dictionary  Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    RETURN  ${dict}

Create the headers for the delete request
    [Arguments]  ${token}
    &{dict} =  Create Dictionary  Content-Type=application/json    Cookie=token=${token}
    RETURN  ${dict}

