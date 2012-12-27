charcutio-web
=============

Meat on the web

Data API
--------

Simple implementation to get started with data pushing.

Create a new box, returns box id.

    POST /boxes {"api_key": "API_KEY", "name": "Box Name"}
    
Report data point

    POST /boxes/:id/report {"api_key": "API_KEY", "type": "temp", "value": 55.6} 
