# class class_name inerhit class_inherited
class Article < ApplicationRecord
    belongs_to :user
    # Validates that title is part of the article
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
end