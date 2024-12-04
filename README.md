# API Testing - Comparing Postman and Robot Framework with RequestsLibrary 

#### Table of Contents

- [Introduction](#Introduction)
- [API Testing vs UI Testing](#API-Testing-vs-UI-Testing)
- [Acknowledgements](#Acknowledgements)



### Introduction

This repository has been created to explain, how to use Robot Framework with RequestsLibray to automate tests that you might carry out using postman.

##### API Methods
_APIs have several methods used to Create, read, update and delete._<br> 
_They are:_
* POST
* GET
* PUT 
* PATCH
* DELETE

_The general rule of thumb is POST is used to create, GET is used to read, PUT and PATCH are used to update and DELETE to delete._<br>
_A request uses one of the methods (POST, GET, PUT, PATCH or DELETE) and when executed sends a response. We are usually looking for the response to be '200' which means its OK._<br>
_Depending on the API, and how it was developed, it may or may not be programmed to send additional information. We can verify our tests by capturing these responses and asserting we are getting the correct response when we carry out a request._

_Our Test_<br>
_Request-->Do Something with an API Method --> Actual response --> Compare Actual response vs Expected response --> Pass or Fail_


### API Testing Vs UI Testing
_When testing the UI, in theory we just need the url of the website, and we can start testing but with APIs there is no UI involved. We need to be given the documentation for each API we are testing._

#### API Documentation
_There is an excellent website, [Restful Booker](https://restful-booker.herokuapp.com/), created by [Mark Winterington](http://mwtestconsultancy.co.uk/), for practicing API testing. I will be using this website and its content to help explain using  Robot Framework to test its APIs. This is a great resource for learning and has links to more learning sources for those who want to expand their knowledge. I would definetly recommend you check those out._

### Robot Framework testing using RequestsLibrary

We need to import the requests library. Here is the documentation, [Requests Library](https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html), which contains all the information you might need as well as explanations and notes on all the keywords.

The Restfull booker sites lists the API's in the following order:

* GetBookingIds
  * All IDs
  * By a single filter
  * By multiple filters
* GetBooking
* CreateBooking
* UpdateBooking
* PartialUpdateBooking
* DeleteBooking

We will go through each one and create a Robot Framework test to validate the API.

#### GetBookingIds

#### All ID's

Lets have a look at the Documentation provided for this API
![Image](Resources/Images/API_docs/getAllIDs.png "Snip of the API Documentation")
<br>1, is a general description of the API. Note it will return something.
<br>2, is the request type in this case "GET".
<br>3, is the url we use to send to the API.<br>
The documentation also states what it will return. A status code of "OK" if it is successful and an object with a list of booking ID's.<br>
![Image](Resources/Images/API_docs/getAllIDsReturn.png "Snip of the API Return Documentation")


We'll start writing the first test to get all the booking ID's<br>
![Image](Resources/Images/API_docs/Get_1.png "Snip of the first test")<br>
We need to create a variable to store what's going to be returned, as we might want to use that information to test something else. The "GET" keyword in the library can accept an argument to check the expected status, it's set by default to expect OK. Robot Framework lets us pass default arguments to keywords.<br><br>

So let's refactor this test, to include a step to count the number of bookings and check the expected status of the request.<br>
![Image](Resources/Images/API_docs/Get_2.png "Snip of the first test refactored")<br>
The status from the API request is OK otherwise the first step would have failed. We are saving the results of our request in a variable. We can count the number of ID's returned by getting the length of the variable, <span style="color:red">${response}</span>. We specify to the "Get Length" keyword that the variable is a json file ${response.json()}.

#### By a single filter 
Going back to the Documentation got "GetBookingIds" and selecting the 

### Acknowledgements



