*** Settings ***
Documentation       API Practice Tests

Resource        ../Resources/all_resources.resource

*** Test Cases ***

Test 1a: Get all the booking ID's
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]  donotrun
    ${response} =  GET    https://restful-booker.herokuapp.com/booking  expected_status=OK
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 1b: Get all the bookings with a specific first name, "John"
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]  donotrun
    ${response} =  GET    url=https://restful-booker.herokuapp.com/booking?firstname=John
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 1c: Get all the bookings with a specific name, "Sally Brown"
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    [Tags]  donotrun
    ${response} =  GET    url=https://restful-booker.herokuapp.com/booking?firstname=Sally&lastname=Brown
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}

Test 2: Get the information for the booking with id=1
    [Documentation]  Returns the fields for the booking with the given id
    [Tags]  donotrun
    ${response} =  GET  url=https://restful-booker.herokuapp.com/booking/1
    Log To Console   This is the booking info ${response.json()}

Test 3: Create a booking (Refactored)
    [Documentation]  Creates a new booking in the API
    ${booking_dates}    Create Dictionary    checkin=2025-04-23    checkout=2025-04-30
    ${pre_body} =  Create Dictionary    firstname=Jon    lastname=Connor    totalprice=200   depositpaid=true
    ...     bookingdates=${booking_dates}
    ${response} =  POST    url=https://restful-booker.herokuapp.com/booking    json=${pre_body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    ${post_body} =  GET  url=https://restful-booker.herokuapp.com/booking/${id}
    Lists Should Be Equal    ${pre_body}   ${post_body.json()}



    