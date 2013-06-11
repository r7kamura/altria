## GET /jobs/:job_id/builds
Returns builds of the job

```
GET /jobs/1072/builds
```

### response
```
Status: 200
response: 
[
  {
     "created_at" => "2013-06-11T17:48:09Z",
    "finished_at" => nil,
             "id" => 395,
         "job_id" => 1072,
         "output" => nil,
     "properties" => {},
     "started_at" => nil,
         "status" => nil,
     "updated_at" => "2013-06-11T17:48:09Z"
  }
]
```


## GET /jobs/:job_id/builds/:id
Returns the build

```
GET /jobs/1073/builds/396
```

### response
```
Status: 200
response: 
{
   "created_at" => "2013-06-11T17:48:09Z",
  "finished_at" => nil,
           "id" => 396,
       "job_id" => 1073,
       "output" => nil,
   "properties" => {},
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-11T17:48:09Z"
}
```


## POST /jobs/:job_id/builds
Creates a new build and queue it

```
POST /jobs/1074/builds
```

### response
```
Status: 201
location: http://www.example.com/jobs/1074/builds/397
response: 
{
   "created_at" => "2013-06-11T17:48:09Z",
  "finished_at" => nil,
           "id" => 397,
       "job_id" => 1074,
       "output" => nil,
   "properties" => {},
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-11T17:48:09Z"
}
```


## PUT /jobs/:job_id/builds/:id
Updates the build

```
PUT /jobs/1075/builds/398
```

### parameters
* `status` integer


### response
```
Status: 204
response: 
```


## DELETE /jobs/:job_id/builds/:id
Deletes the build

```
DELETE /jobs/1076/builds/399
```

### response
```
Status: 204
response: 
```

