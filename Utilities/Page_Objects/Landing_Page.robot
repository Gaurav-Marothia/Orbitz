*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${FLIGHTS}  //span[.='Flights']
${SEARCH_BTN}   //button[.='Search']
${BASEURL}  https://www.orbitz.com/
${ROUNDTRIP}    //span[.='Roundtrip']

*** Keywords ***
Orbitz site is opened
    Go To   ${BASEURL}
    Wait Until Page Contains Element    ${SEARCH_BTN}

User Navigates to Flights Section
    Click Element   ${FLIGHTS}
    Wait Until Page Contains Element    ${ROUNDTRIP}