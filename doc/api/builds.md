## GET /jobs/:job_id/builds
Returns builds of the job.

### request
```
GET /jobs/:job_id/builds
```

### response
```ruby
Status: 200
response: 
[
  {
    "id": 23,
    "status": null,
    "started_at": null,
    "finished_at": "2013-12-11T00:09:24.000+09:00",
    "job_id": 32,
    "output": null,
    "created_at": "2013-12-11T00:09:24.000+09:00",
    "updated_at": "2013-12-11T00:09:24.000+09:00",
    "properties": {
    },
    "incremental_id": 1
  }
]
```

## GET /builds/:id
Returns the build.

### request
```
GET /builds/:id
```

### response
```ruby
Status: 200
response: 
{
  "id": 35,
  "status": null,
  "started_at": null,
  "finished_at": "2013-12-11T00:09:24.000+09:00",
  "job_id": 34,
  "output": null,
  "created_at": "2013-12-11T00:09:24.000+09:00",
  "updated_at": "2013-12-11T00:09:24.000+09:00",
  "properties": {
  },
  "incremental_id": 1
}
```

## POST /jobs/:job_id/builds
Creates a new build and queue it.

### request
```
POST /jobs/:job_id/builds
```

### response
```ruby
Status: 201
Location: http://www.example.com/builds/36
response: 
{
  "id": 36,
  "status": null,
  "started_at": null,
  "finished_at": null,
  "job_id": 35,
  "output": null,
  "created_at": "2013-12-11T00:09:24.584+09:00",
  "updated_at": "2013-12-11T00:09:24.584+09:00",
  "properties": {
  },
  "incremental_id": 1
}
```

## PUT /builds/:id
Updates the build.

### parameters
* `status` integer

### request
```
PUT /builds/:id
```

```
status=1
```

### response
```ruby
Status: 204
response: 
```

## DELETE /builds/:id
Deletes the build.

### request
```
DELETE /builds/:id
```

### response
```ruby
Status: 204
response: 
```
