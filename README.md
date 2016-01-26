# EmotionalBalloon

## PagingTree
### Public
```
Top (/)
├── Product
│   ├── List (/products)
│   ├── Feature (/products/feature)
│   ├── Ranking (/products/ranking)
│   └── Show (/products/show)
├── Cart
│   ├── Register (/carts/register)
│   ├── Comfirm (/carts/comfirm)
│   ├── Thanks (/carts/thanks)
│   └── Show (/carts/show)
└── Company
    ├── Agreement (/company/agreement)
    ├── Privacy (/company/privacy)
    ├── Exchange (/company/exchange)
    ├── Question (/company/question)
    ├── About (/company/about)
    ├── Flow (/company/flow)
    └── Contact (/company/contact)
```

### Admin
```
Dashboard (/admin)
├── Login (/admin/login)
├── Product
│   ├── List
│   │   ├── All (/admin/products?filter=all)
│   │   ├── Public (/admin/products?filter=public)
│   │   ├── Secret (/admin/products?filter=secret)
│   │   └── None (/admin/products?filter=none)
│   ├── New (/admin/products/new)
│   ├── Show (/admin/products/:id)
│   └── Edit (/admin/products/:id/edit)
├── Order
│   ├── List
│   │   ├── All
│   │   ├── Unconfirmed
│   │   ├── Process
│   │   └── Complete
│   ├── Show
│   └── Edit
├── Category
└── Customer
    ├── List
    ├── New
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
| character | :character |

##### Responce
```
{
    "data": {
        "current_page": 2,
        "max_page": 5,
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