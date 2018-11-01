

For Capistrano deployment, configure deploy.rb with your info.
Configre config/database.yml with your DB info.
Set the secret key within config/initializers/secret_token.rb
Set your email info within config/initializers/devise.rb
Set config/environments/
In app/helpers/application/helper, update the meta_description,
  meta_keywords, and page_title to suit your site
Update app/mailers/comment_notifier.rb with to and from email addresses
Update views, as desired, with customized text.
