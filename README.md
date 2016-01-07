# EmotionalBalloon

## PagingTree
### Public
```
Top
├── Product
│   ├── List
│   ├── Scene
│   ├── Feature
│   ├── Ranking
│   ├── Search
│   ├── Curt
│   └── Show
└── Company
    ├── Agreement
    ├── Privacy
    ├── Exchange
    ├── Question
    ├── About
    ├── Flow
    └── Contact
```

### Admin
```
Home
├── Login
├── Product
│   ├── List
│   │   └── All
│   ├── New
│   ├── Show
│   └── Edit
└── Order
    ├── List
    │   ├── All
    │   ├── Unconfirmed
    │   ├── Process
    │   └── Complete
    ├── Show
    └── Edit
```

## API
### Product
#### GET /api/product/search
| Parameter | Value |
|:-:|:-:|
| page | :page |
| min | :min_price |
| max | :max_price |
| scene | :scene |

##### Responce
```
{
    "data": {
        "current_page": 2,
        "max_page": 5,
        "product_list": [
            {
                "id": 1,
                "name": "SAMPLE",
                "price": 3000,
                "image": "http://sample.com/img/sample.jpg"
            }
        ]
    }
}
```

#### GET /api/prouct/ranking
| Parameter | Value |
|:-:|:-:|
|  |  |

##### Responce
```
{
    "data": {
        "product_list": [
            {
                "id": 1,
                "name": "SAMPLE",
                "price": 3000,
                "image": "http://sample.com/img/sample.jpg"
            }
        ]
    }
}
```