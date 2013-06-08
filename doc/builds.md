## GET /jobs/:job_id/builds
Returns builds of the job

```
GET /jobs/8252/builds
```

### response
```
Status: 200
response: 
[
  {
     "created_at" => "2013-06-08T12:35:21Z",
    "finished_at" => nil,
             "id" => 3219,
         "job_id" => 8252,
         "output" => nil,
     "started_at" => nil,
         "status" => nil,
     "updated_at" => "2013-06-08T12:35:21Z"
  }
]
```


## GET /jobs/:job_id/builds/:id
Returns the build

```
GET /jobs/8253/builds/3220
```

### response
```
Status: 200
response: 
{
   "created_at" => "2013-06-08T12:35:21Z",
  "finished_at" => nil,
           "id" => 3220,
       "job_id" => 8253,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T12:35:21Z"
}
```


## POST /jobs/:job_id/builds
Creates a new build and queue it

```
POST /jobs/8254/builds
```

### response
```
Status: 201
location: http://www.example.com/jobs/8254/builds/3221
response: 
{
   "created_at" => "2013-06-08T12:35:22Z",
  "finished_at" => nil,
           "id" => 3221,
       "job_id" => 8254,
       "output" => nil,
   "started_at" => nil,
       "status" => nil,
   "updated_at" => "2013-06-08T12:35:22Z"
}
```


## PUT /jobs/:job_id/builds/:id
Updates the build

```
PUT /jobs/8255/builds/3222
```

### parameters
* `status` string


### response
```
Status: 204
response: 
```


## DELETE /jobs/:job_id/builds/:id
Deletes the build

```
DELETE /jobs/8256/builds/3223
```

### response
```
Status: 204
response: 
```

