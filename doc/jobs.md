## GET /jobs
Returns jobs

```
GET /jobs
```

### response
```ruby
Status: 200
response: 
[
  {
    "id"         => 1031,
    "name"       => "name 17",
    "properties" => {},
    "created_at" => "2013-07-05T15:55:44.000Z",
    "updated_at" => "2013-07-05T15:55:44.000Z"
  }
]
```


## GET /jobs/:id
Returns the job

```
GET /jobs/1032
```

### response
```ruby
Status: 200
response: 
{
  "id"         => 1032,
  "name"       => "name 18",
  "properties" => {},
  "created_at" => "2013-07-05T15:55:44.000Z",
  "updated_at" => "2013-07-05T15:55:44.000Z"
}
```


## POST /jobs
Creates a new job

```
POST /jobs
```

### parameters
* `name` string (required)

### response
```ruby
Status: 201
response: 
{
  "id"         => 1033,
  "name"       => "name",
  "properties" => {
    "description" => "description"
  },
  "created_at" => "2013-07-05T15:55:44.714Z",
  "updated_at" => "2013-07-05T15:55:44.714Z"
}
```


## PUT /jobs/:id
Updates the job

```
PUT /jobs/1034
```

### parameters
* `name` string

### response
```ruby
Status: 204
response: 
```

