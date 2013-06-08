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
        "config" => {},
    "created_at" => "2013-06-08T12:35:22Z",
            "id" => 8257,
          "name" => "name 13",
    "updated_at" => "2013-06-08T12:35:22Z"
  }
]
```


## GET /jobs/:id
Returns the job

```
GET /jobs/8258
```

### response
```
Status: 200
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T12:35:22Z",
          "id" => 8258,
        "name" => "name 14",
  "updated_at" => "2013-06-08T12:35:22Z"
}
```


## POST /jobs
Creates a new job

```
POST /jobs
```

### parameters
* `name` string (required)
* `config` string


### response
```
Status: 201
location: http://www.example.com/jobs/8259
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T12:35:22Z",
          "id" => 8259,
        "name" => "name",
  "updated_at" => "2013-06-08T12:35:22Z"
}
```


## PUT /jobs/:id
Updates the job

```
PUT /jobs/8261
```

### parameters
* `name` string
* `config` string


### response
```
Status: 204
response: 
```

