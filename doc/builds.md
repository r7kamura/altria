## GET /jobs/:job_id/builds
Returns builds of the job

```
GET /jobs/8270/builds
```

### response
```
Status: 200
response: 
[
  {
     "created_at" => "2013-06-08T12:48:39Z",
    "finished_at" => nil,
             "id" => 3226,
         "job_id" => 8270,
         "output" => nil,
     "started_at" => nil,
         "status" => nil,
     "updated_at" => "2013-06-08T12:48:39Z"
  }
]
```


## GET /jobs/:job_id/builds/:id
Returns the build

```
GET /jobs/8271/builds/3227
```

### response
```
Status: 200
response: 
{
   "created_at" => "2013-06-08T12:48:39Z",
  "finished_at" => nil,
           "id" => 3227,
       "job_id" => 8271,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T12:48:39Z"
}
```


## POST /jobs/:job_id/builds
Creates a new build and queue it

```
POST /jobs/8272/builds
```

### response
```
Status: 201
location: http://www.example.com/jobs/8272/builds/3228
response: 
{
   "created_at" => "2013-06-08T12:48:39Z",
  "finished_at" => nil,
           "id" => 3228,
       "job_id" => 8272,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T12:48:39Z"
}
```


## PUT /jobs/:job_id/builds/:id
Updates the build

```
PUT /jobs/8273/builds/3229
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
DELETE /jobs/8274/builds/3230
```

### response
```
Status: 204
response: 
```

