Feature: Status endpoint
    Status endpoint

    Scenario: Status endpoint should response correctly
        Given service is working by command "python /vol/src/frup/run.py"

        When I send "GET" request to "/status"

        Then I expect staus code "200"
        And I expect response containing json:
            """
            {
                "status": "ok"
            }
            """