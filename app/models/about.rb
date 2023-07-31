class About < ApplicationRecord
<<<<<<< HEAD

    def self.ransackable_attributes(auth_object = nil)
        ["title", "description", "content"]
      end
    
      def self.ransackable_associations(auth_object = nil)
        []
      end
      
end
=======
    validates :title, presence: true
    validates :content, presence: true
  
    def self.ransackable_attributes(auth_object = nil)
      super - ['id', 'created_at', 'updated_at']
    end
  end
  
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
