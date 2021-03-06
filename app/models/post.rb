class Post < ApplicationRecord
   extend FriendlyId
   friendly_id :title, use: :slugged

   belongs_to :category
   belongs_to :user

   has_many :taggings # join table
   has_many :tags, through: :taggings
   has_many :comments

   scope :published, lambda { where(published: true)}
   scope :unpublished, -> { where(published: false)}

   scope :limit_5, -> { limit(5)}
   scope :order_by_latest_first, -> { order(created_at: :desc)}

   # File upload
   has_one_attached :featured_image

   # tag_ids

   # let's create an action text
   has_rich_text  :description

   validates_presence_of :title, :category_id, :description

   def all_tags=(names) 
      if names.blank? 
         return 
      end
      # ruby, rails
      self.tags = names.split(",").map do |name| 
         unless name.blank?  
            Tag.where(name: name.strip).first_or_create!
         end
      end
   end

   def all_tags 
      tags.map(&:name).join(", ")
   end

   #helper/custom method
   def post_body 
      self.description.body
   end

end

