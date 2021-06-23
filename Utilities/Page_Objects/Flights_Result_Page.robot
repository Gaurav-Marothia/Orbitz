*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${NONSTOP}  //*[@name="fs0" or @name='stops']
${CONT_BTN}    //button[.='Continue']
${price_tags_unavailable}   //li[@data-test-id="offer-listing"]//div[@data-test-id="intersection-observer"]   #//*[@class="uitk-price-a11y is-visually-hidden"]
${price_tags}   //*[@class="uitk-price-a11y is-visually-hidden" or @data-test-id="listing-price-dollars"]
${max_price}    //*[contains(text(), '$1,123.14')]
${select_btn}   //*[@class="btn-secondary btn-action t-select-btn"][@data-test-id='select-button']  #css=.btn-secondary.btn-action.t-select-btn[data-test-id='select-button'][data-bargain-fare='false'][data-click-handler='select-flight,omnitureClickHandler'][data-prevent-expand='true']    #//*[@class="btn-secondary btn-action t-select-btn"]//*[contains(text(), 'Select')]
${leaving_from}    //*[@id='departure-airport-1' or @aria-label="Flying from San Francisco, CA (SFO-San Francisco Intl.)"]   #//*[contains(text(), 'San Francisco, CA (SFO-San Francisco Intl.)') or contains(text(), 'San Francisco, CA, United States of America (SFO)')]
${leaving_to}    //*[@id='arrival-airport-1' or @aria-label="Flying to New York (NYC-All Airports)"]    #//input[@id='arrival-airport-1']   #//*[contains(text(), 'New York (NYC-All Airports)') or contains(text(), 'New York, NY, United States of America (NYC)')]
${from_to}    //*[.='San Francisco to New York']
${to_from}    //*[.='New York to San Francisco']
${review}    //li[.='Review your trip']
${trip_total}    //span[@class="uitk-text uitk-type-500 uitk-type-bold uitk-text-emphasis-theme"]
${trip_price}   css=div[class='uitk-price-lockup uitk-flex-item left-align'] span[class='uitk-lockup-price']

*** Keywords ***
Selects nonstop flights
    Sleep    10S
    ${flying_from}    Get Text    ${leaving_from}
    Run Keyword If    '${flying_from}'=='San Francisco, CA (SFO-San Francisco Intl.)'    Log To Console    Flying from city displayed is same as entered
    ...    ELSE    Log To Console    Flying from city displayed is not same as entered

    ${flying_to}    Get Text    ${leaving_to}
    Run Keyword If    '${flying_to}'=='New York (NYC-All Airports)'    Log To Console    Flying to city displayed is same as entered
    ...    ELSE    Log To Console    Flying to city displayed is not same as entered

#    ${start_date}   Get Text    //button[@id="start-date-ROUND_TRIP-0-btn"]
#    Should Be Equal As Strings    ${sd}    ${start_date}
#    ${end_date}   Get Text    //button[@id="end-date-ROUND_TRIP-0-btn"]
#    Should Be Equal As Strings    ${ed}    ${end_date}

    Execute JavaScript    window.scrollTo(0,300)
    Wait Until Keyword Succeeds    60s    2s    Select Checkbox    ${NONSTOP}
    Sleep    5s

User select the expensive flight from the result list
    ${price_ele}    Get WebElements    ${price_tags}
    ${price_ele_un}    Get WebElements    ${price_tags_unavailable}
#    ${price_ele_av}    Get WebElements    ${price_tags_available}
    ${select_btn_ele}   Get WebElements    ${select_btn}
    ${price_count}    Get Element Count    ${price_tags}
    ${price_count_ele_un}    Get Element Count    ${price_tags_unavailable}
#    ${price_count_ele_av}    Get Element Count    ${price_tags_available}
    ${select_count_ele}    Get Element Count    ${select_btn}



    FOR    ${element}    IN    @{price_ele}
            ${text}=    Get Text    ${element}
            Log    ${text}
    END

    sleep   5s

    ${select_btn_visible}=  Run Keyword And Return Status    Element Should Be Visible   ${select_btn}
    Run Keyword If    ${select_btn_visible}    Scroll Element Into View    (${select_btn})[${select_count_ele}]
    ...    ELSE    Set Focus To Element    (${price_tags_unavailable})[${price_count_ele_un}]

    sleep   5s

    ${select_btn_visible}=  Run Keyword And Return Status    Element Should Be Visible   ${select_btn}
    Run Keyword If    ${select_btn_visible}    Click Element    (${select_btn})[${select_count_ele}]
    ...    ELSE    Click Element    (${price_tags_unavailable})[${price_count_ele_un}]
#    ${IsElementVisible}=  Run Keyword And Return Status    Element Should Be Visible   ${select_btn}

    Click Element    ${CONT_BTN}
    Wait Until Keyword Succeeds    60s    2s    Select Checkbox    ${NONSTOP}
    Wait Until Keyword Succeeds    60s    2s    Click Element    (${price_tags_unavailable})[1]
    ${price_per_traveler}    Get Text    ${trip_price}
    ${price_per_traveler_conv}    Remove String    ${price_per_traveler}   $    ,
    ${ROUND_TRIP_PRICE}    Convert To Number    ${price_per_traveler_conv}
    Set Global Variable    ${ROUND_TRIP_PRICE}
    Click Element    ${CONT_BTN}

User books the flight and reviews the details
    Select Window    NEW
    Wait Until Element Is Visible    ${review}
    ${sf_ny}    Get Text    ${from_to}
    Should Be Equal As Strings      ${sf_ny}    San Francisco to New York
    Scroll Element Into View    ${to_from}
    ${ny_sf}    Get Text    ${to_from}
    Should Be Equal As Strings    ${ny_sf}    New York to San Francisco
    Scroll Element Into View    ${trip_total}
    ${total}    Get Text    ${trip_total}
    ${total_cv}    Remove String    ${total}    $    ,
    ${total_price}    Convert To Number   ${total_cv}
    Should Be Equal As Strings    ${ROUND_TRIP_PRICE}    ${total_price}