# miniblog

This is a simple blog in Ruby on Rails 3.2. It allows the user to set up categories, add posts to the categories, and update or delete both. Users can log in to make comments, and the main user, as admin, can delete comments after they are made. After a user write a blog posting, it will be saved as draft, so the user must go to the admin page to publish the posting.

See a video walkthrough here: http://www.mbondpro.com/2018/11/mini-blog-code-and-walkthrough.html

To set up, don't forget to perform the following actions:

For Capistrano deployment, configure deploy.rb with your info.
Configre config/database.yml with your DB info.
Set the secret key within config/initializers/secret_token.rb
Set your email info within config/initializers/devise.rb
Set config/environments/
In app/helpers/application/helper, update the meta_description,
  meta_keywords, and page_title to suit your site
Update app/mailers/comment_notifier.rb with to and from email addresses
Update views, as desired, with customized text.
