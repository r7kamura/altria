## GET /jobs/:job_id/builds
Returns builds of the job

```
GET /jobs/2078/builds
```

### response
```
Status: 200
response: 
[
  {
     "created_at" => "2013-06-08T06:49:59Z",
    "finished_at" => nil,
             "id" => 808,
         "job_id" => 2078,
         "output" => nil,
     "started_at" => nil,
         "status" => nil,
     "updated_at" => "2013-06-08T06:49:59Z"
  }
]
```


## GET /jobs/:job_id/builds/:id
Returns the build

```
GET /jobs/2079/builds/809
```

### response
```
Status: 200
response: 
{
   "created_at" => "2013-06-08T06:49:59Z",
  "finished_at" => nil,
           "id" => 809,
       "job_id" => 2079,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T06:49:59Z"
}
```


## POST /jobs/:job_id/builds
Creates a new build and queue it

```
POST /jobs/2080/builds
```

### response
```
Status: 201
location: http://www.example.com/jobs/2080/builds/810
response: 
{
   "created_at" => "2013-06-08T06:50:00Z",
  "finished_at" => nil,
           "id" => 810,
       "job_id" => 2080,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T06:50:00Z"
}
```


## PUT /jobs/:job_id/builds/:id
Updates the build

```
PUT /jobs/2081/builds/811
```

### response
```
Status: 204
response: 
```


## DELETE /jobs/:job_id/builds/:id
Deletes the build

```
DELETE /jobs/2082/builds/812
```

### response
```
Status: 204
response: 
```

