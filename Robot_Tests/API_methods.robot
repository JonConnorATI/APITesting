*** Settings ***
Documentation       API_METHODS

Resource        ../Resources/all_resources.resource

*** Test Cases ***

Test 1a: Get all the booking ID's
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]
    ${response} =  GET    https://restful-booker.herokuapp.com/booking  expected_status=OK
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 1b: Get all the bookings with a specific first name, "John"
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]
    ${response} =  GET    url=https://restful-booker.herokuapp.com/booking?firstname=John
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 1c: Get all the bookings with a specific name, "Sally Brown"
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]
    ${response} =  GET    url=https://restful-booker.herokuapp.com/booking?firstname=Sally&lastname=Brown
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 2: Get the information for the booking with id=1
    [Documentation]  Returns the fields for the booking with the given id
    [Tags]
    ${response} =  GET  url=https://restful-booker.herokuapp.com/booking/1
    Log To Console   This is the booking info ${response.json()}

Test 3: Create a booking (Refactored)
    [Documentation]  Creates a new booking in the API
    [Tags]
    ${booking_dates}    Create Dictionary    checkin=2025-04-23    checkout=2025-04-30
    ${pre_body} =  Create Dictionary    firstname=Jon    lastname=Connor    totalprice=200   depositpaid=false
    ...     bookingdates=${booking_dates}
    ${response} =  POST    url=https://restful-booker.herokuapp.com/booking    json=${pre_body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    ${post_body} =  GET  url=https://restful-booker.herokuapp.com/booking/${id}
    Lists Should Be Equal    ${pre_body}   ${post_body.json()}


Test 4: Update Booking
    [Documentation]  1.Get the auth token-->2.Create a booking-->3.Update the booking-->4.Verify all updated
    [Tags]
    ################### 1. Get the authorisation ###################
    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=https://restful-booker.herokuapp.com/auth    json=${body}
    Log    ${response.json()}
    ${token}    Set Variable    ${response.json()}[token]
    ${auth_header} =  Create Dictionary  Cookie=token\=${token}
   ################### 2. Create a booking and get the ID ###################
    ${booking_dates}    Create Dictionary    checkin=2025-04-23    checkout=2025-04-30
    ${pre_body} =  Create Dictionary    firstname=Jon    lastname=Connor    totalprice=200   depositpaid=true
    ...     bookingdates=${booking_dates}
    ${response} =  POST    url=https://restful-booker.herokuapp.com/booking    json=${pre_body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    ################### 3. Update the booking ###################
    ${new_booking_dates}    Create Dictionary    checkin=2025-05-23    checkout=2025-05-30
    ${updated_body} =  Create Dictionary    firstname=Dave    lastname=Roconn    totalprice=300   depositpaid=true
    ...     bookingdates=${new_booking_dates}  additionalneeds=Dinner, Bed and Breakfast
    ${updated_booking} =  PUT  url=https://restful-booker.herokuapp.com/booking/${id}
    ...                      json=${updated_body}  headers=${auth_header}
    ################### 4. Verify all updated ###################
    ${new_body} =  GET  url=https://restful-booker.herokuapp.com/booking/${id}
    Lists Should Be Equal    ${updated_body}   ${new_body.json()}

Test 5: Partially Update the booking that has ID=2 with new additional needs
    [Documentation]  1.Get the auth token-->2. Partially Update a booking by ID-->3.Verify the partial update
    [Tags]
    ################### 1. Get the authorisation ###################
    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=https://restful-booker.herokuapp.com/auth    json=${body}
    Log    ${response.json()}
    ${token}    Set Variable    ${response.json()}[token]
    ${auth_header} =  Create Dictionary  Cookie=token\=${token}
    ################### 2. Partially Update a booking ###################
    ${new_add_needs}    Create Dictionary    additionalneeds=room with double bed and shower
    ${updated_booking} =  PATCH  url=https://restful-booker.herokuapp.com/booking/2
    ...                      json=${new_add_needs}  headers=${auth_header}
    ################### 3. Verify partial update ###################
    ${new_body} =  GET  url=https://restful-booker.herokuapp.com/booking/2
    List Should Contain Sub List  ${new_body.json()}  ${new_add_needs}

Test 6: Delete a booking by ID=101
    [Documentation]  1.Get the auth token-->2. Delete booking by ID-->3.Verify the Deletion
    [Tags]
     ################### 1. Get the authorisation ###################
    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=https://restful-booker.herokuapp.com/auth    json=${body}
    Log    ${response.json()}
    ${token}    Set Variable    ${response.json()}[token]
    ${auth_header} =  Create Dictionary  Cookie=token\=${token}
    ################### 2. Delete Booking by ID ###################
    ${Delete_Booking} =  DELETE    url=https://restful-booker.herokuapp.com/booking/101
    ...                         headers=${auth_header}  expected_status=201
    # Log  ${Delete_Booking.json()}
    ################### 3. Verify the deletion ###################
    GET  url=https://restful-booker.herokuapp.com/booking/101  expected_status=404
















