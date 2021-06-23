*** Settings ***
Library  SeleniumLibrary
Library  DateTime
Library  String
Library  BuiltIn
Resource  ../../Utilities/Page_Objects/Landing_Page.robot

*** Variables ***
${DEPARTURE_FROM}   //button[@aria-label="Leaving from"]
${ARRIVAL_TO}    //button[@aria-label="Going to"]
${DEPARTURE_TXT_BOX}    location-field-leg1-origin
${ARRIVAL_TXT_BOX}    location-field-leg1-destination
${DEPARTURE_DATE}   //button[@id="d1-btn"]
${ARRIVAL_DATE}    //button[@id="d2-btn"]
${DEPARTURE_CITY}   //span[.='San Francisco (SFO - San Francisco Intl.)']
${ARRIVAL_CITY}    //span[.='New York (NYC - All Airports)']
${CHOOSE_DEPARTING_FLIGHT}  (//span[.='Choose departing flight'])[2]
${NONSTOP}  //*[@name="fs0" or @name='stops']

*** Keywords ***
Selects leaving from as San Francisco and going to as New York
    Click Element   ${DEPARTURE_FROM}
    Wait Until Keyword Succeeds    60s    2s    Input Text  ${DEPARTURE_TXT_BOX}   San Franc
    Click Element   ${DEPARTURE_CITY}
    Click Element   ${ARRIVAL_TO}
    Wait Until Keyword Succeeds    60s    2s    Input Text  ${ARRIVAL_TXT_BOX}   New York
    Click Element   ${ARRIVAL_CITY}

Selects departing & returning dates and clicks on search btn
    Wait Until Keyword Succeeds    60s    2s    Click Element   d1-btn
    Convert Date    14 days
    Select Date    ${cv_year}    ${cv_month}    ${cv_date}    14 days
    Press Keys    NONE    ESC
    Wait Until Keyword Succeeds    60s    2s    Click Element   d2-btn
    Convert Date    21 days
    Select Date    ${cv_year}    ${cv_month}    ${cv_date}    21 days
    Press Keys    NONE    ESC
    Set Focus To Element    ${SEARCH_BTN}
    Click Element   ${SEARCH_BTN}

Select Date    [Arguments]    ${year}    ${month}    ${date}    ${days}
    ${currentdate}    Get Current Date    result_format=datetime
    ${add_t_date}   Add Time To Date   ${currentdate}    ${days}   %d
    ${add_t_month}   Add Time To Date   ${currentdate}    ${days}    %b
    ${add_t_year}   Add Time To Date   ${currentdate}    ${days}   , %Y
    ${date_to_int}    Convert To Integer  ${add_t_date}
    ${result}  Catenate    ${add_t_month}   ${date_to_int}${add_t_year}
    ${sd}    Catenate    ${add_t_month}   ${date_to_int}
    ${ed}    Catenate    ${add_t_month}   ${date_to_int}

    Set Suite Variable     ${sd}
    Set Suite Variable     ${ed}

    Convert To Integer    ${year}
    Convert To Integer    ${month}
    Convert To Integer    ${date}
    ${month-diff}    Evaluate    ${month}-${currentdate.month}
    ${year-diff}    Evaluate    ${year}-${currentdate.year}
    ${move}    Evaluate    ${year-diff}*12+${month-diff}

    ${shiftforward}    Set Variable If
    ...    ${move}>0    1
    ...    ${move}<0    0

    ${move}    Set Variable If
    ...    ${move}>0    ${move}
    ...    ${move}<0    ${move}*-1

    FOR    ${var}    IN RANGE    ${move}
        Run Keyword If    ${shiftforward}==0    Click Element    (//button[@data-stid="date-picker-paging"])[2]
        Run Keyword If    ${shiftforward}==1    Click Element    (//button[@data-stid="date-picker-paging"])[1]
    END

    Execute JavaScript    window.scrollTo(0,300)
    Wait Until Keyword Succeeds    60s    2s    Click Element     //*[@aria-label="${result}" or @aria-label="${result} selected, current check in date."]

Convert Date    [Arguments]     ${days}
    ${cd}   Get Current Date    UTC    14 days    result_format=%Y%m%d
    ${cd_date}  Get Substring   ${cd}    -2
    ${cv_date}  Convert To Integer    ${cd_date}
    ${cd_month}  Get Substring   ${cd}    -4    -2
    ${cv_month}  Convert To Integer    ${cd_month}
    ${cd_year}  Get Substring   ${cd}    -8    -4
    ${cv_year}  Convert To Integer    ${cd_year}

    Set Suite Variable    ${cv_date}
    Set Suite Variable    ${cv_month}
    Set Suite Variable    ${cv_year}