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
    "created_at" => "2013-06-08T06:50:00Z",
            "id" => 2083,
          "name" => "name 13",
    "updated_at" => "2013-06-08T06:50:00Z"
  }
]
```


## GET /jobs/:id
Returns the job

```
GET /jobs/2084
```

### response
```
Status: 200
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T06:50:00Z",
          "id" => 2084,
        "name" => "name 14",
  "updated_at" => "2013-06-08T06:50:00Z"
}
```


## POST /jobs
Creates a new job

```
POST /jobs
```

### response
```
Status: 201
location: http://www.example.com/jobs/2085
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T06:50:00Z",
          "id" => 2085,
        "name" => "name",
  "updated_at" => "2013-06-08T06:50:00Z"
}
```


## PUT /jobs/:id
Updates the job

```
PUT /jobs/2087
```

### response
```
Status: 204
response: 
```

