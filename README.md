performance-api
===============

Calls supported
---------------
GET /api/performance -
Gets a list of performances. 
 
POST /api/performance - 
Post a new performance.
    
GET /api/performance/:id - 
Get a single performance.

PUT /api/performance/:id - 
Update a single performance's:
 - name
 - description
 - instruments
 - video link

DELETE /api/performance/:id - 
Delete an individual performance.

PUT /api/performance/:id/rate - 
Update a rating for a performance.

POST /api/performance/:id/comments - 
Add a comment to the performance.

Schema of a Performance
-----------------------
    {
    "_id": "541b4eaf51963439fd000002",
    "video_ref": "http://www.youtube.com/watch?v=A43JOxLa5MM",
    "user": "stodd",
    "name": "Metal GiG",
    "__v": 2,
    "comments": [
        {
            "user": "stodd",
            "body": "Heavy...",
            "_id": "541b539b58ccedd0fd000002",
            "created_dt": "2014-09-18T21:40:26.301Z",
            "id": "541b539b58ccedd0fd000002"
        },
        {
            "user": "stodd",
            "body": "Vegan metal chef has nothing on you.",
            "_id": "541b540758ccedd0fd000003",
            "created_dt": "2014-09-18T21:40:26.301Z",
            "id": "541b540758ccedd0fd000003"
        }
    ],
    "create_dt": "2014-09-18T21:29:04.572Z",
    "rating_sum": 12,
    "rating_count": 5,
    "instruments": [
        "rooster",
        "awesome"
    ],
    "avgRating": 2.4,
    "id": "541b4eaf51963439fd000002"
    }
Next Steps
----------
* Add pagination to listing call.
* Add api key and request signing to pull up user making request. This is to prevent a user from rating his own performance (See code comments). I assume a method is already in place.
* Better response codes on errors.
* Add swagger for API documentation.
* Utilize socketIO to post performance updates in real time.
