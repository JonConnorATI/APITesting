*** Settings ***
Documentation       API Practice Tests

Resource        ../Resources/all_resources.resource

*** Test Cases ***


Create a valid booking in the system
    [Documentation]  A POST request is made to create a booking
    ...              To be valid all the required data must be included in the request body.
    ...                 1.Customer makes booking.
    ...                 2.Booking is succesful.
    ...                 3.Customer now has a Booking ID.
    [Tags]
    ${Request_Body} =  Create random data for a valid booking request body
    Set Suite Variable  ${Request_Body}
    ${booking_response} =  Post a valid booking to the system  ${Request_Body}
    Set Suite Variable  ${Booking_ID}  ${booking_response.json()}[bookingid]

Confirm the details in a booking by ID
    [Documentation]  A GET request using the booking ID should return the correct booking information
    ...                 1.Customer contacts Business and provides Booking ID.
    ...                 2.Business checks the ID is for the correct booking.
    [Tags]
    ${Booking_Info_Confirm} =  Get the booking information for a booking by id  ${Booking_ID}
    Lists Should Be Equal    ${Request_Body}    ${Booking_Info_Confirm}

Change all the details in a Booking with an ID
    [Tags]
    [Documentation]  A PUT request is made to an existing booking ID with an authorisation code
    ...                 1.Customer has new booking details to update existing booking
    ...                 2.Business (or Customer) logs in and changes the booking
    ...                 3.Booking with the ID has been updated
    ${Request_Body_Update_All} =  Create random data for a valid booking request body
    &{LogIn} =  Create the Log in Body for the request
    ${token} =  Create a session, Log in and get the authorisation token  update_session  ${authURL}  ${LogIn}
    &{headers} =  Create the headers for the update request  ${token}
    ${Booking_Info_updated} =  Update a booking fully using the Booking ID  update_session  ${bookingURL}  ${Booking_ID}
    ...                        ${headers}  ${Request_Body_Update_All}
    Lists Should Be Equal    ${Booking_Info_updated}    ${Request_Body_Update_All}

Change some of the details in a Booking with an ID
    [Documentation]  A PATCH request is made to an existing booking ID  with an authorisation code
    ...                 1.Customer has new booking details to partially update existing booking
    ...                 2.Business (or Customer) logs in and changes the booking
    ...                 3.Booking with the ID has been updated
    [Tags]
    ${Request_Body_Update_additionalNeeds} =  Create random data for a partial update booking request body
    &{LogIn} =  Create the Log in Body for the request
    ${token} =  Create a session, Log in and get the authorisation token  update_session  ${authURL}  ${LogIn}
    &{headers} =  Create the headers for the update request  ${token}
    ${Booking_Info_updated} =  Update a booking partially using the Booking ID  update_session  ${bookingURL}  ${Booking_ID}
    ...                        ${headers}  ${Request_Body_Update_additionalNeeds}
    List Should Contain Sub List    ${Booking_Info_updated}  ${Request_Body_Update_additionalNeeds}

Delete a booking using the ID
    [Documentation]  A DELETE request is made to an existing booking ID with an authorisation code
    ...                 1.Customer wants to delete an existing booking
    ...                 2.Business (or Customer) logs in and deletes the booking
    ...                 3.Booking with the ID no longer exists
    [Tags]
    &{LogIn} =  Create the Log in Body for the request
    ${token} =  Create a session, Log in and get the authorisation token  update_session  ${authURL}  ${LogIn}
    &{headers} =  Create the headers for the delete request  ${token}
    ${Booking_Info_updated} =  Delete a booking using the Booking ID  update_session  ${bookingURL}  ${Booking_ID}
    ...                        ${headers}
    Log   ${Booking_Info_updated}






  
    
