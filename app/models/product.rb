class Product < ApplicationRecord
<<<<<<< HEAD
    belongs_to :category
    
    mount_uploader :image, ImageUploader
    has_many :orders
    belongs_to :supplier
    has_many :order_items

    def self.ransackable_attributes(auth_object = nil)
        ["category_id", "created_at", "description", "id", "image", "mat_id", "name", "price", "supplier_id", "uom", "updated_at"]
      end
      def self.ransackable_associations(auth_object = nil)
        %w(category supplier orders)
      end
      def self.ransackable_attributes(auth_object = nil)
        super + ['on_sale']
      end
end
=======
  belongs_to :category
  belongs_to :supplier
  mount_uploader :image, ImageUploader
  before_create :generate_mat_id

  def generate_mat_id
    self.mat_id = SecureRandom.hex(4)
  end

  def self.ransackable_attributes(auth_object = nil)
    super + %w[on_sale category_id created_at description id mat_id name price supplier_id uom updated_at image]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category supplier]
  end
  class Product < ApplicationRecord
    # ...
  
    def self.search(category_id, keyword)
      products = self.all
  
      if category_id.present?
        products = products.where(category_id: category_id)
      end
  
      if keyword.present?
        products = products.where("name LIKE ?", "%#{keyword}%")
      end
  
      products
    end
  

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where("created_at >= ?", 3.days.ago) }
  scope :recently_updated, -> { where("updated_at >= ?", 3.days.ago) }
end
end
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
