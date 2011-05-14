require 'acts_as_king/railtie' if defined?(Rails)

# Written by Drew Tempelmeyer
module ActsAsKing
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # Defines that the model should have a self referencing hierarchy. This allows you to have threaded comments or any other type
    # of self referencing hierarchy. <tt>ActsAsKing</tt> creates a belongs_to
    # association (parent) and has_many association (children). It also defines
    # a <tt>kings</tt> scope for your model to return all top level records.
    #
    # === Example
    #
    #   class Comment < ActiveRecord::Base
    #     acts_as_king
    #   end
    #
    #   comment_1 = Comment.create
    #   comment_2 = Comment.create(:parent => comment_1) # defines parent
    #
    #   # return an array of all top level records
    #   Comment.kings # => [#<Comment id: 1>]
    #
    #   # return an array of children belonging to comment_1
    #   comment_1.children # => [#<Comment id: 2>]
    #
    #   # get the parent record for comment_2
    #   comment_2.parent # => #<Comment id: 1>
    #
    #
    def acts_as_king(options = {})
      options = { :foreign_key => 'parent_id' }.merge(options)

      belongs_to :parent, :class_name => name, :foreign_key => options[:foreign_key]
      has_many :children, :class_name => name, :foreign_key => options[:foreign_key], :dependent => :destroy

      class_eval <<-EOL
        include ActsAsKing::InstanceMethods

        scope :kings, where("#{options[:foreign_key]} IS NULL")
      EOL

    end

  end

  module InstanceMethods
    
    # Retrieves all of the parents of the instance. (Think of it including
    # grandparents as well.)
    #
    # ==== Example
    #
    # If you had three records in a structure similar to this:
    #   #<Comment id: 1, parent_id: nil>
    #     #<Comment id: 2, parent_id: 1>
    #       #<Comment id: 3, parent_id: 2>
    # 
    # You would do the following to return all ancestors
    #   comment_3.ancestors # => [#<Comment id: 2, parent_id: 1>, #<Comment id: 1, parent_id: nil>]
    #
    def ancestors
      current, all = self, []
      all << current = current.parent while current.parent
      all
    end

  end

end
