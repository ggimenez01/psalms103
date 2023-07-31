class Category < ApplicationRecord
<<<<<<< HEAD
    has_many :products

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "name", "updated_at"]
      end

      def self.ransackable_attributes(auth_object = nil)
        ['name', 'description'] + super
      end
    
      def self.ransackable_associations(auth_object = nil)
        ['products']
end
end
=======
  has_many :products, foreign_key: 'category_id'
  validates :name, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end

  # ...
end
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
