*** Settings ***
Library      SeleniumLibrary
Library      Collections


*** Variables ***
${BROWSER}                    Chrome
${DRIVER_PATH}                C:/Python3.9/Scripts/chromedriver
${FLIGHT_WEB_URL}             https://www.flightradar24.com/data/airports/pnq
${ARRIVALS_LABEL}             //label[text()='Arrivals ']
${EST_TIME_DETAILS}           (//span[text()='Bengaluru ']/..//..//following-sibling::td)[4]
${SHOW_ALL_LINK}              //label[text()='Arrivals ']//a

*** Test Cases ***
Get All Flights Information
    Navigate to Flightradar24
    Verify Flight Arriavals detials
    Close The Browser

*** Keywords ***
Navigate to Flightradar24
    open browser                             ${FLIGHT_WEB_URL}          ${BROWSER}
    maximize browser window
    wait until page contains element         ${ARRIVALS_LABEL}
    wait until element is visible            ${ARRIVALS_LABEL}
    wait until element is visible            ${SHOW_ALL_LINK}
    click element                            ${SHOW_ALL_LINK}

Verify Flight Arriavals detials
    ${flights}      Get Flights From Cities     Bengaluru    Delhi   Goa   Chandigarh  Hyderabad   Nagpur   Dubai
    Log Many        @{flights}

Get Flights From Cities
    [Arguments]  @{cities}
    @{flight_statuses}  Create List
    FOR  ${city}  IN  @{cities}
        ${flight_status}  Get Flight Status  ${city}
        Append To List  ${flight_statuses}  ${flight_status}
    END
    RETURN  ${flight_statuses}


Get Flight Status
    [Arguments]         ${city_names}
    Sleep                                      10s
    ${loc}              Set Variable           (//span[text()='${city_names} ']/..//..//following-sibling::td)[4]
    Wait Until Page Contains Element           ${loc}
    Wait Until Element Is Visible              ${loc}
    ${flight_info}  Get Text                   ${loc}
    Run Keyword If  '${flight_info}' != 'No data available'  Log  @ ${city_names}: ${flight_info}
    ...  ELSE  Log  @ ${city_names}: data not available
    RETURN  ${flight_info}

Close The Browser
    close all browsers