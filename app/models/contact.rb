class Contact < ApplicationRecord
<<<<<<< HEAD
    def self.ransackable_attributes(auth_object = nil)
        ["name", "email", "address", "phone_number"]
      end
    
      def self.ransackable_associations(auth_object = nil)
        []
      end
      
end
=======
  validates :title, :address, :telephone_number, :email, :website, presence: true

  
    def self.ransackable_attributes(auth_object = nil)
      super + ['title']
    end
  end
  
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
