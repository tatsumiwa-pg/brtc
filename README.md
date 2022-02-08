<h1 align="center">ﾈｺと和解せよ<br>
-BeReconciledToCat-</h1>

![nekotowakaiseyo-title](https://user-images.githubusercontent.com/91407881/151696574-a4bdbe4c-1750-4e5a-9210-c03542124952.png)


<br>

___

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
<br>

<h1 align="center">DB</h1>

# *user-related*

## users
| Column             | Type     | Options                   |
|--------------------|----------|---------------------------|
| nickname           | string   | null: false, unique: true |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| deleted_at         | datetime |                           |


### Association
- has_many :consultations
- has_many :answers
- has_many :cons_comments
- has_many :ans_comments
- has_many :reviews
- has_one  :profile

<br>

---

<br>

## profiles
| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| age         | integer    | null: false                    |
| job         | string     | null: false                    |
| skills      | string     | null: false                    |
| address     | string     | null: false                    |
| cat_exp     | string     | null: false                    |
| family_type | integer    | null: false                    |
| house_env   | integer    | null: false                    |
| my_cats     | text       | null: false                    |
| introduce   | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

<br>

---

<br>

# *consultation-related*

## consultations
| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| cons_title  | string     | null: false                    |
| category_id | integer    | null: false                    |
| summary     | string     | null: false                    |
| situation   | text       | null: false                    |
| problem     | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many   :answers
- has_one    :reconciliation
- has_many   :cons_comments

---

<br>

## reconciliation
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| rec_text     | string     | null: false                    |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation

<br>

---

<br>

## cons_comments
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| cons_c_text  | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation

<br>

---

<br>

# *answer-related*

## answers
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| ans_title    | string     | null: false                    |
| ans_text     | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :consultation
- has_one    :review
- has_many   :ans_comments

<br>

---

<br>

## reviews
| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| point   | integer    | null: false                    |
| user    | references | null: false, foreign_key: true |
| answer  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :answer

<br>

---

<br>

## ans_comments
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| ans_c_text | string     | null: false                    |
| user       | references | null: false, foreign_key: true |
| answer     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :answer 

<br>

---

<br>

# *tag-related*

## tags
| Column   | Type   | Options                        |
|----------|--------|--------------------------------|
| tag_name | string | null: false                    |

### Association
- has_many :consultation_tags
- has_many :consultations, through: :consultation_tags 

<br>

---

<br>

## consultation_tags
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| consultation | references | null: false, foreign_key: true |
| tag          | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation
- belongs_to :tag
