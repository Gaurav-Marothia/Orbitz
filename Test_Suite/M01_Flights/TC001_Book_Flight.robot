*** Settings ***
Resource    ../../Utilities/Page_Objects/Landing_Page.robot
Resource  ../../Utilities/Page_Objects/Flights_Page.robot
Resource  ../../Utilities/Page_Objects/Flights_Result_Page.robot
Resource  ../../Resources/Common.robot
Suite Setup  Log To Console    Suite Execution Started...
Suite Teardown  Log To Console  Suite Execution Ended...
Test Setup  Begin Web Test
#Test Teardown  End Web Test

*** Test Cases ***
Book Expensive Flight from San Fancisco To New York
    Orbitz site is opened
    User Navigates to Flights Section
    Selects leaving from as San Francisco and going to as New York
    Selects departing & returning dates and clicks on search btn
    Selects nonstop flights
    User select the expensive flight from the result list
    User books the flight and reviews the details

#    robot -v BROWSER:chrome testsuite
#    pabot --argumentfile1 arg_chrome.txt --argumentfile2 arg_firefox.txt -v Test_Suite