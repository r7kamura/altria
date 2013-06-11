## GET /jobs
Returns jobs

```
GET /jobs
```

### response
```
Status: 200
response: 
[
  {
    "created_at" => "2013-06-11T17:48:09Z",
            "id" => 1077,
          "name" => "name 15",
    "properties" => {},
    "updated_at" => "2013-06-11T17:48:09Z"
  }
]
```


## GET /jobs/:id
Returns the job

```
GET /jobs/1078
```

### response
```
Status: 200
response: 
{
  "created_at" => "2013-06-11T17:48:09Z",
          "id" => 1078,
        "name" => "name 16",
  "properties" => {},
  "updated_at" => "2013-06-11T17:48:09Z"
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
```
Status: 201
location: http://www.example.com/jobs/1079
response: 
{
  "created_at" => "2013-06-11T17:48:09Z",
          "id" => 1079,
        "name" => "name",
  "properties" => {
    "description" => "description"
  },
  "updated_at" => "2013-06-11T17:48:09Z"
}
```


## PUT /jobs/:id
Updates the job

```
PUT /jobs/1080
```

### parameters
* `name` string


### response
```
Status: 204
response: 
```

