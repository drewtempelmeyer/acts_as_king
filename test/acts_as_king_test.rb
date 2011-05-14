require './test/helper'

class ActsAsKingTest < Test::Unit::TestCase

  context "ActsAsKing" do

    setup do
      setup_db
      @post = Post.create
      @comment = Comment.create(:post => @post)
      @sub_comment = Comment.create(:post => @post, :parent => @comment)
      @level_3 = Comment.create(:post => @post, :parent => @sub_comment)
    end

    teardown do
      destroy_db
    end

    should "be one post" do
      assert_equal 1, Post.count
    end

    should "be three comments" do
      assert_equal 3, Comment.count
    end

    should "be one king comment" do
      assert_equal 1, Comment.kings.count
    end

    should "king comment should have one child" do
      assert_equal 1, @comment.children.count
    end

    should "child comment should return array of parents" do
      assert_equal [@comment], @sub_comment.ancestors
    end

    should "return multiple ancestors" do
      assert_equal [@sub_comment, @comment], @level_3.ancestors
    end
    
  end

end

