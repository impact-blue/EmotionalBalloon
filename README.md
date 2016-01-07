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
│   ├── Cart
│   ├── Register
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
| page | :page |

##### Responce
```
{
    "data": {
        "current_page": 1,
        "max_page": 3,
        "product_list": [
            {
                "id": 4,
                "name": "テスト",
                "price": 2000,
                "image": "http://sample.com/img/sample.jpg",
                "scenes": [
                    {
                        "id": 1,
                        "scene": "marriage",
                        "created_at": "2016-01-07T10:40:23.000+09:00",
                        "updated_at": "2016-01-07T10:40:23.000+09:00",
                        "name": "結婚式"
                    }
                ],
                "charas": [
                    {
                        "id": 1,
                        "chara": "sanrio",
                        "name": "サンリオ",
                        "created_at": "2016-01-07T10:40:23.000+09:00",
                        "updated_at": "2016-01-07T10:40:23.000+09:00"
                    }
                ],
                "colors": [
                    {
                        "id": 1,
                        "color": "white",
                        "created_at": "2016-01-07T10:40:23.000+09:00",
                        "updated_at": "2016-01-07T10:40:23.000+09:00",
                        "name": "白色"
                    }
                ],
                "balloon_types": []
            }
        ]
    }
}
```

#### GET /api/product/detail
| Parameter | Value |
|:-:|:-:|
| id | :id |

##### Responce
```
{
    "data": {
        "id": 4,
        "name": "テスト",
        "price": 2000,
        "image": "http://sample.com/img/sample.jpg",
        "scenes": [
            {
                "id": 1,
                "scene": "marriage",
                "created_at": "2016-01-07T10:40:23.000+09:00",
                "updated_at": "2016-01-07T10:40:23.000+09:00",
                "name": "結婚式"
            }
        ],
        "charas": [
            {
                "id": 1,
                "chara": "sanrio",
                "name": "サンリオ",
                "created_at": "2016-01-07T10:40:23.000+09:00",
                "updated_at": "2016-01-07T10:40:23.000+09:00"
            }
        ],
        "colors": [
            {
                "id": 1,
                "color": "white",
                "created_at": "2016-01-07T10:40:23.000+09:00",
                "updated_at": "2016-01-07T10:40:23.000+09:00",
                "name": "白色"
            }
        ],
        "balloon_types": []
    }
}
```