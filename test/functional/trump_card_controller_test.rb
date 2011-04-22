require File.dirname(__FILE__) + '/../test_helper'

class TrumpCardControllerTest < ActionController::TestCase

  def test_should_render_play
    get :play, :game => 'tennis'
    assert_not_nil assigns(:card1)
    assert_not_nil assigns(:card2)
    assert_not_equal assigns(:card1), assigns(:card2)
    assert_not_nil assigns(:property_names)
    assert_equal 'tennis', assigns(:game)
    assert_template 'play'
  end

  def test_should_render_index
    get :index
    assert_template 'index'
  end

  def test_should_show_wins_result
    get :result, {:game => "test_cricket", :name => "SR Tendulkar (India)", :other_name => "R Dravid (ICC/India)", :property => "Runs"}
    assert_equal :wins,assigns(:result)
  end

  def test_should_set_game_again
    get :result, {:game => "test_cricket", :name => "SR Tendulkar (India)", :other_name => "R Dravid (ICC/India)", :property => "Runs"}
    assert_equal "test_cricket" ,assigns(:game)
  end

  def test_should_show_invalid_result
    get :result, {:game => "tennis", :name => "SR Tendulkar (India)", :other_name => "R Dravid (ICC/India)", :property => "Runs"}
    assert_equal :invalid,assigns(:result)
  end

  def test_should_show_loses_result
    get :result, {:game => "test_cricket", :other_name => "SR Tendulkar (India)", :name => "R Dravid (ICC/India)", :property => "Runs"}
    assert_equal :loses,assigns(:result)
    assert_equal "SR Tendulkar (India)", assigns(:other_card).name
    assert_equal "R Dravid (ICC/India)", assigns(:my_card).name
    assert_equal "Runs", assigns(:property)
  end


  def test_should_show_loses_result_for_tennis
    get :result, {:game => "tennis", :name => "Mats Wilander", :other_name => "Stefan edberg", :property => "Wins"}
    assert_equal :loses,assigns(:result)
  end

end