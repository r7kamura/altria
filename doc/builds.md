## GET /jobs/:job_id/builds
Returns builds of the job

```
GET /jobs/1025/builds
```

### response
```ruby
Status: 200
response: 
[
  {
    "id"          => 1,
    "status"      => nil,
    "started_at"  => nil,
    "finished_at" => nil,
    "job_id"      => 1025,
    "output"      => nil,
    "created_at"  => "2013-07-05T15:55:44.000Z",
    "updated_at"  => "2013-07-05T15:55:44.000Z",
    "properties"  => {}
  }
]
```


## GET /builds/:id
Returns the build

```
GET /builds/1
```

### response
```ruby
Status: 200
response: 
{
  "id"          => 1,
  "status"      => nil,
  "started_at"  => nil,
  "finished_at" => nil,
  "job_id"      => 1027,
  "output"      => nil,
  "created_at"  => "2013-07-05T15:55:44.000Z",
  "updated_at"  => "2013-07-05T15:55:44.000Z",
  "properties"  => {}
}
```


## POST /jobs/:job_id/builds
Creates a new build and queue it

```
POST /jobs/1028/builds
```

### response
```ruby
Status: 201
response: 
{
  "id"          => 683,
  "status"      => nil,
  "started_at"  => nil,
  "finished_at" => nil,
  "job_id"      => 1028,
  "output"      => nil,
  "created_at"  => "2013-07-05T15:55:44.565Z",
  "updated_at"  => "2013-07-05T15:55:44.565Z",
  "properties"  => {}
}
```


## PUT /builds/:id
Updates the build

```
PUT /builds/1
```

### parameters
* `status` integer

### response
```ruby
Status: 204
response: 
```


## DELETE /builds/:id
Deletes the build

```
DELETE /builds/1
```

### response
```ruby
Status: 204
response: 
```

