require 'test_helper'

class AvailableMenuItemsControllerTest < ActionController::TestCase
  context 'GET available_menu_items#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)

    should 'load available menu items' do
      assert assigns[:available_menu_items], 'Should load items'
    end
  end

  context 'GET available_menu_items#query' do
    setup do
      date_range_data = { date_range: { begin_date: '2014-11-17',
                                        end_date: '2014-11-18' } }
      get :query, date_range_data
    end

    should render_template('query')
    should respond_with(:success)

    should 'load available menu items' do
      assert assigns[:available_menu_items], 'Should load items'
    end

    should 'only load items within range' do
      assert_equal 2, assigns[:available_menu_items].count, 'should only be two'
    end
  end

  context 'DELETE available_menu_items#destroy' do
    setup { delete :destroy, id: available_menu_items(:one) }

    should 'remove vendor from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        AvailableMenuItem.find(available_menu_items(:one).id)
      end
    end
  end
end