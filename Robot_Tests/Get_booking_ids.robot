*** Settings ***
Documentation       API Practice Tests

Resource        ../Resources/all_resources.resource

*** Test Cases ***

Test 1: Get all the booking ID's
    [Documentation]  Returns the ids of all the bookings that exist within the API.
    ${response} =  GET    https://restful-booker.herokuapp.com/booking  expected_status=OK
    ${no_of_bookings} =  Get Length    ${response.json()}
    Log To Console    No of bookings is ${no_of_bookings}




  
    