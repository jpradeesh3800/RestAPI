class Book < ApplicationRecord
    validates :B_title, presence: true
    validates :Author, presence: true
    validates :Publisher, presence: true
    validates :Year, :numericality => { greater_than: 0 }
end
