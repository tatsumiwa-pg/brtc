<h1 align="center">ﾈｺと和解せよ<br>
-ToCatBeReconciled-</h1>

![to_cat_be_reconciled_tobira](https://user-images.githubusercontent.com/91407881/149545046-2ed7d879-45bb-4d90-b72b-e59fc1c8c8d2.png)

<br>

___

<br>

<h1 align="center">DB</h1>

# *user-related*

## users
| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many :consultations
- has_many :answers
- has_many :c_comments
- has_many :a_comments
- has_many :reviews
- has_one  :profile

<br>

---

<br>

## profiles
| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| age         | integer    |                                |
| job         | string     |                                |
| skill       | string     |                                |
| address     | string     |                                |
| cat_exp     | string     |                                |
| family_type | string     |                                |
| house_env   | string     |                                |
| my_cat      | string     |                                |
| introduce   | text       |                                |
| user        | references | null: false, foreign_key: true |

<br>

---

<br>

# *consultation-related*

## consultations
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| cons_title | string     | null: false                    |
| category   | integer    | null: false                    |
| summary    | string     | null: false                    |
| situation  | text       | null: false                    |
| problem    | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many   :answers
- has_one    :reconciliation
- has_many   :c_comments

---

<br>

## reconciliation
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| rec_text     | string     |                                |
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
- has_many   :a_comments

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
