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
    "created_at" => "2013-06-08T12:48:39Z",
            "id" => 8275,
          "name" => "name 13",
    "updated_at" => "2013-06-08T12:48:39Z"
  }
]
```


## GET /jobs/:id
Returns the job

```
GET /jobs/8276
```

### response
```
Status: 200
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T12:48:39Z",
          "id" => 8276,
        "name" => "name 14",
  "updated_at" => "2013-06-08T12:48:39Z"
}
```


## POST /jobs
Creates a new job

```
POST /jobs
```

### parameters
* `name` string (required)
* `config` hash


### response
```
Status: 201
location: http://www.example.com/jobs/8277
response: 
{
      "config" => {},
  "created_at" => "2013-06-08T12:48:39Z",
          "id" => 8277,
        "name" => "name",
  "updated_at" => "2013-06-08T12:48:39Z"
}
```


## PUT /jobs/:id
Updates the job

```
PUT /jobs/8279
```

### parameters
* `name` string
* `config` hash


### response
```
Status: 204
response: 
```

