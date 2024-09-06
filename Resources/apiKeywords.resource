*** Settings ***

Resource            all_resources.resource


*** Variables ***



*** Keywords ***

Post API
    [Arguments]  ${body}  ${Status}
    ${response} =  POST  ${bookingURL}  json=${body}  expected_status=${Status}
    RETURN  ${response}

GET API
    [Arguments]  ${id}  ${Status}
    ${response} =  GET       ${bookingURL}${id}  expected_status=${Status}
    RETURN  ${response}

Post a valid booking to the system
    [Arguments]  ${body}
    ${response} =  Post API  ${body}  OK
    RETURN  ${response}

Get the booking information for a booking by id
    [Arguments]  ${id}
    ${response} =  GET API  ${id}  OK
    RETURN  ${response.json()}

Create a session, Log in and get the authorisation token
    [Arguments]  ${session}  ${url}  ${body}
    Create Session    ${session}   url=${url}
    ${Auth_response} =  POST On Session  ${session}   url=${url}  json=${body}  expected_status=200
    RETURN  ${Auth_response.json()}[token]

Update a booking fully using the Booking ID
    [Arguments]  ${session}  ${url}  ${ID}  ${headers}  ${body}
    ${Booking_update_all} =  PUT On Session  update_session  url=${url}${ID}
    ...                      json=${body}  headers=${headers}  expected_status=OK
    ${Booking_Info_updated} =  Get the booking information for a booking by id  ${ID}
    RETURN  ${Booking_Info_updated}

Update a booking partially using the Booking ID
    [Arguments]  ${session}  ${url}  ${ID}  ${headers}  ${body}
    ${Booking_update_all} =  PATCH On Session  update_session  url=${url}${ID}
    ...                      json=${body}  headers=${headers}  expected_status=OK
    ${Booking_Info_updated} =  Get the booking information for a booking by id  ${ID}
    RETURN  ${Booking_Info_updated}

Delete a booking using the Booking ID
    [Arguments]  ${session}  ${url}  ${ID}  ${headers}
    ${Booking_update_all} =  Delete On Session  update_session  url=${url}${ID}
    ...                      headers=${headers}  expected_status=201
    RETURN  ${Booking_update_all}

