# The Tests For My Impersonates User Example

Miss the example?  Find it here
[//www.brownwebdesign.com/blog/2014/02/04/logon-as-another-user-in-a-rails-app][1]

#### The integration spec

```ruby
# spec/requests/impersonates_spec.rb
describe "Impersonating an Author" do
  context "when logged in as an admin" do
    context "and switching to an author" do
      let(:admin){ create(:user, :admin) }
      let!(:author){ create(:author) }

      it 'logs in the admin as the author and can sign the admin back in' do
        sign_in_user admin
        click_link "Authors"
        page.should have_content author.name
        click_link "Sign in as this author"
        page.should have_content "Signed in as"
        find(".author-logout").click
        page.should have_content "Signed out"
        click_link "Sign in as admin"
        page.should have_content "Signed back in as admin"
      end
    end
  end

  context "when logged in as another author" do
    let!(:author2){ create(:author, email: 'author2@gsu.com') }
    it 'will not allow the author to sign in as another author' do
      sign_in author2
      visit authors_path
      should_see_cancan_error page
    end
  end
end
```

#### Controller spec

```ruby
# spec/controller/impersonates_controller_spec.rb
describe ImpersonatesController do
  let(:admin){ create(:user, :admin) }
  let!(:author2){ create(:author, email: 'author2@gsu.com') }

  context "logged in as an admin" do
    login_admin

    it 'allows the admin to sign in as the author' do
      post :create, :author_id => author2.id
      response.should redirect_to(dashboard_author_path(author2))
    end

    it 'allows the admin to resign in as the admin' do
      # set the session first
      post :create, :author_id => author2.id
      delete :destroy, id: "revert"
      response.should redirect_to(user_path(@user))
    end

  end

  context "signed in as an another author" do
    login_author
    it 'will not allow the author to sign in as another author' do
      post :create, :author_id => author2.id
      response.should redirect_to(root_path)
    end

    it 'will not allow the author to use the create action and give themself a :admin_logged_in flag' do
      post :create, :id => @user.id
      response.should redirect_to(root_path)
    end

    it 'wont allow access to the index action' do
      delete :destroy, id: "revert"
      response.should redirect_to(root_path)
    end
  end
end
```

[1]:/blog/2014/02/04/logon-as-another-user-in-a-rails-app
