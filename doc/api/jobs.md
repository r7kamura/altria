## GET /jobs
Returns jobs.

### request
```
GET /jobs
```

### response
```ruby
Status: 200
response: 
[
  {
    "id": 38,
    "name": "name 17",
    "properties": {
    },
    "created_at": "2013-12-11T00:09:24.000+09:00",
    "updated_at": "2013-12-11T00:09:24.000+09:00",
    "builds_count": 0
  }
]
```

## GET /jobs/:id
Returns the job.

### request
```
GET /jobs/:id
```

### response
```ruby
Status: 200
response: 
{
  "id": 39,
  "name": "name 18",
  "properties": {
  },
  "created_at": "2013-12-11T00:09:24.000+09:00",
  "updated_at": "2013-12-11T00:09:24.000+09:00",
  "builds_count": 0
}
```

## POST /jobs
Creates a new job.

### parameters
* `name` string (required)

### request
```
POST /jobs
```

```
name=name&description=description
```

### response
```ruby
Status: 201
Location: http://www.example.com/jobs/40
response: 
{
  "id": 40,
  "name": "name",
  "properties": {
    "description": "description"
  },
  "created_at": "2013-12-11T00:09:24.841+09:00",
  "updated_at": "2013-12-11T00:09:24.841+09:00",
  "builds_count": 0
}
```

## PUT /jobs/:id
Updates the job.

### parameters
* `name` string

### request
```
PUT /jobs/:id
```

```
name=name&description=description
```

### response
```ruby
Status: 204
response: 
```
