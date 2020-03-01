# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|nickname|string|null: false|
|profile_image|text||
|profile_text|text||
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|phone|string|null: false,unique:true|

### Association
 has_many : products
 has_many : comments
 has_many : addresses
 has_many : likes
 has_many : cards
 has_many : SNScredentals
 has_many : buys
 has_many : sells



## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|size|string|null: false|
|condition|string|null: false|
|detail|text|null: false|
|brand|references|null: false, foreign_key: true|
|category|references|null: false, foreign_key: true|
|shipping_fee|string||
|shippng_method|string|null: false|
|shipping_date|string|null: false|
|shipping_s_area|string|null: false|
|sell|references|null: false, foreign_key: true|
|buy|references|null: false, foreign_key: true|

### Association
has_many : comments
has_many : likes
has_many : images
belongs_to : user
belongs_to : brand
belongs_to : category
belongs_to : buy
belongs_to : sell



## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|nummber|string|null: false|
|prefecture|string|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building name|string||
|address_phone|string|null: false,unique:true|

### Association
belongs_to : user



## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|card_nummber|string|null: false|
|card_month|string|null: false|
|card_year|string|null: false|
|security_code|string|null: false|

### Association
belongs_to : user



## SNScredentialsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|uid|string|null: false|
|provider|string|null: false|

### Association
belongs_to : user



## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
belongs_to : user
belongs_to : product



## buysテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|

### Association
has_many : products
belongs_to : user



## sellsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|

### Association
has_many : products
belongs_to : user



## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
belongs_to : user
belongs_to : product



## imageテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|product|references|null: false, foreign_key: true|

### Association
belongs_to : product



## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
has_many : products



## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
|parent_id|string||

### Association
has_many : products


