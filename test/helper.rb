$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'logger'
require 'active_record'
require 'acts_as_king'
require 'test/unit'
require 'shoulda'

ActiveRecord::Base.send(:include, ActsAsKing)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.verbose = false

ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV['SHOW_SQL'] && ENV['SHOW_SQL'] == 'true'

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :posts, :force => true do |t|
    end

    create_table :comments, :force => true do |t|
      t.integer :post_id, :null => false
      t.integer :parent_id
      t.integer :comments_count
    end
  end
end

def destroy_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
end

class Comment < ActiveRecord::Base
  belongs_to :post
  acts_as_king :counter_cache => true
end

