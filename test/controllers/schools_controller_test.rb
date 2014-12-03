require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def create_regular_user
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  def create_school_admin
    @admin = User.create!(first_name: 'First',
                          last_name: 'Last',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password')
    @admin.add_role :admin, schools(:one)
    sign_in @admin
  end

  def valid_school_data
    { school: {  name: "Charter School",
                 id: 1,
                 description: "Public Montessori",
                 motto: "independent learning",
                 address: "NC",
                 phone: "919-919-9191" } }
  end

  context 'GET schools#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)
  end

  context 'POST schools#create' do
    setup { post :create, { school: valid_school_data } }

    should 'create school' do
      assert_saved_model(:school)
    end

    should 'redirect to school show' do
      assert assigns[:school]
    end
  end


  context 'PATCH schools#update' do
    setup { patch :update, { id: schools(:one), school: valid_school_data } }

    should 'update school with new params' do
      @school = School.find(schools(:one).id)
      assert_equal 'MyString', @school.name
      assert_equal 'MyString', @school.phone
    end

  end

  context 'GET schools#show' do
    setup { get :show, { id: schools(:one).id } }

    should render_template('show')
    should respond_with(:success)
  end

end
